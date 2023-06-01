Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50D71A0BD
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 16:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjFAOqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjFAOp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 10:45:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D731B8
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 07:45:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f6c6320d4eso220031cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jun 2023 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685630738; x=1688222738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj/+F86ImX5bW6d1HCDCVFjQFnm+jmUbdbf0quByU6M=;
        b=TNCLAftt3Sq3ibkhD0YZTfkW5mUDcT6HDFygkTiE/ZIUkWpteiBdW/IWdD7REpV/15
         aMo4rYTS2NmIard6ca23NRCb5X4vJ7dEjp3GE83gKHmzWiIPOhn4m+IjShzjlaGr3jPf
         CZKHiyW1sgcqAxVUWtprGk3w94EjLk2MUi/f0S4PXOU/Tn/+FJNcBvHYk9XLsA7ckuQM
         y+ycyQTPOiV05UJ6JCrACyNfcV/MkfCxVJhy9g3XRtGrbDsdMmw6AOi1sph3MjP2PgzL
         jAaOSFjMqyaeBholQjRFB90SGtCRzJKNuaVvdISBfzlv/hkyCcW9NNdSyqvOmom8ggYb
         VycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630738; x=1688222738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj/+F86ImX5bW6d1HCDCVFjQFnm+jmUbdbf0quByU6M=;
        b=KQ+CiunljmjHh6/lR6PE4o1J/ci/GEuShnYtc8wEwwWh/HLPe3WXDzjqws+TGo1wwY
         o3owod9Nzbr55qliCWzgBK0v7/yEJH3p4RII9J9HKf/oNJr7ivAYdH/k2Dx2A8pPRed+
         3wKVorMYJeQbvW6d+Y3oM12N5hupDRTTJXwPMTGwQJUAGQoqbXW4JpPmsSDyhpTyJT99
         15qqOWlor1QihOvObv3mVyNi/3B4C5m/LU5UaLSPT+k0wO+xisWonfZwNLUanz4kwbIP
         jmiRr4S1K0R1qoXQ4GhgvNrJfgBlfVyrCvRHXMtZ5PKTjgr4yFzUfDJLycafyjid0VJe
         9FaQ==
X-Gm-Message-State: AC+VfDz6x1pFeMMQqbu4QHjMaCa+v3mU1ZyeT4dfmUZ/sL8vPI0fZav/
        ViQ2SS8D0b9wyQaJdXKySwVutpWI1lukg3hVqVcuwg==
X-Google-Smtp-Source: ACHHUZ5xkFBCJ4QdnzSYurX5+oNIyYqncNNn8stgefcprj14VQmfeyhpOv/H4g5Tcu936Zg1vtTWULVWACs+lMHwtqM=
X-Received: by 2002:a05:622a:1102:b0:3e8:684b:195d with SMTP id
 e2-20020a05622a110200b003e8684b195dmr253911qty.10.1685630738485; Thu, 01 Jun
 2023 07:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
In-Reply-To: <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 1 Jun 2023 16:45:27 +0200
Message-ID: <CALPaoChcra+qJd9ETQT+nZ17ahH0RCCarjuT3jn8EyzV2HyCbw@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
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

Hi Reinette,

On Thu, May 11, 2023 at 11:37=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 4/21/2023 7:17 AM, Peter Newman wrote:
> > +     /* Count bandwidth after the first successful counter read. */
> > +     if (counter->initialized) {
> > +             /* Assume that mbm_update() will prevent double-overflows=
. */
> > +             if (val !=3D counter->prev_bytes)
> > +                     atomic64_add(val - counter->prev_bytes,
> > +                                  &m->soft_rmid_bytes);
> > +     } else {
> > +             counter->initialized =3D true;
> > +     }
> > +
> > +     counter->prev_bytes =3D val;
>
> I notice a lot of similarities between the above and the software control=
ler,
> see mbm_bw_count().

I see the "a=3Dnow(); a-b; b=3Da;" and the not handling overflow parts
being similar, but the use of the initialized flag seems quite
different from delta_comp.

Also mbm_state is on the arch-independent side and the new code is
going to the arch-dependent side, so it wouldn't be convenient to try
to use the mbm_bw structures for this.

From this, I don't think trying to reuse this is worth it unless you
have other suggestions.

-Peter
