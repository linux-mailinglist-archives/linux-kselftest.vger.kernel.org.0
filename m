Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6372448A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjFFNgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjFFNgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:36:13 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4710D2
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 06:36:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f6c6320d4eso174281cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686058571; x=1688650571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlVR62cA6mu9AUFB8C/tzofTcjJ3I5Rt6AhVQL0tGc0=;
        b=sj5gE4bDA4PDFrncJOUfaW9FRDPB3Wa1V3rkMCaEYbJbZKOpdYtr428DazU/1WU1yo
         9ZhYylVyZYaPLoIM65JG/1QPoKgwzSMX8T43Zvjd+P5wimBpDvOrOXgRhi5BlBearaUB
         VyJ7CcK50IKeAA1MesrFdyGm2LJUP64x/b8xtS27j22trxGmKnqt9A7JTnQzxWnmG5K3
         WRlEcaM/GJu9bBSIu9pFShz/rvbQxyGZakYyYFkiA0BN3MzrBOvMq7A4wtk+yd9jE6U/
         yGgmyjObVQ1S5qvE7Nn4BrE4mUJpKpVc/vkzZHXbkGX49fVA1kx4oigiEoONz8ndBEl1
         BDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058571; x=1688650571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlVR62cA6mu9AUFB8C/tzofTcjJ3I5Rt6AhVQL0tGc0=;
        b=XVC9dGPrX6qX23ssuRMuClO4xQRBZiKFFtmGZ/TJPaApWiqzXU2m0KdvZXwEY1/+XB
         A4aHxkAHYXVT5dD4K8m6EqPdYVGQ1KweQlaAuag+N5Awq0F2DcHzbyTCxDx2a1ZiIpp9
         ydM/hGSoBi/cwZAnLWw51iSO9IV33Keq3gHfm9AGipBS+V+2TsUlK5Z+aPgSkGnBQK7F
         woF/JC5FuckqiFPneBnC0HifzJ9i0vMlHU49dqOQ82tMFy6KjyZUpSAU+JbDYBWeUgxC
         YutQ0pN6I83qyl73BZmGK5ObGs6/EPOkACJfVzZvNQkWMaX50SN8xHf4IasJ4XHedYUH
         X3xw==
X-Gm-Message-State: AC+VfDxKhy6MYl2I6icfa1L84N3SnGGtTnmKFaGoLzcqTJYPbVm6JDZr
        lO5gkRmcraMpzTNRddi/KDQuyV/QS8heyjd/ZRKr6g==
X-Google-Smtp-Source: ACHHUZ6GX/U5Qh0RCiW2I8umCHsTaWvxU6NXVJ7f1nFmu9duL9A57HAgFKfM1x97nvyXMUlkE4dNcYRX1cq1PE3vhjs=
X-Received: by 2002:a05:622a:1a9f:b0:3e0:c2dd:fd29 with SMTP id
 s31-20020a05622a1a9f00b003e0c2ddfd29mr200195qtc.4.1686058571603; Tue, 06 Jun
 2023 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com> <20230421141723.2405942-8-peternewman@google.com>
In-Reply-To: <20230421141723.2405942-8-peternewman@google.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 6 Jun 2023 15:36:00 +0200
Message-ID: <CALPaoCgF25n-Rnxxd-Pwo+675LLdSGt-sC2d7C2voS6ueNnL2A@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 21, 2023 at 4:18=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
>  static void clear_closid_rmid(int cpu)
>  {
>         struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
> @@ -604,7 +636,12 @@ static void clear_closid_rmid(int cpu)
>         state->default_rmid =3D 0;
>         state->cur_closid =3D 0;
>         state->cur_rmid =3D 0;
> -       wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +       state->hw_rmid =3D 0;
> +
> +       if (static_branch_likely(&rdt_soft_rmid_enable_key))
> +               state->hw_rmid =3D determine_hw_rmid_for_cpu(cpu);

clear_closid_rmid() isn't run at mount time, so hw_rmid will be
uninitialized on any CPUs which were already enabled. The static key
was originally set at boot.

(the consequence was that domain bandwidth was the amount recorded on
the first CPU in the domain multiplied by the number of CPUs in the
domain)
