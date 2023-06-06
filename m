Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7A724477
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjFFNbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbjFFNbT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:31:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFDC90
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 06:31:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6c6320d4eso173111cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686058277; x=1688650277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu495ErLblvkCqCHGMpwun0U7rLfauxkN4tFcXNAkpw=;
        b=fCgdktNWB2LogtugfQhIIiIvjESV9vkobdDHV7kpj1nHH43vKoyAjogajpYO5qaL96
         HGx2vQMSpYpUjTKXSdp80HyvH7LGmNhAss3khdsLQ6uvbFoWsz6u41mq4FIQibyD9P4e
         4ZvJ1jm3d4KBbGTCmLguUyu99AehOuhORlJU1fkgnIKVbMx2sFmjLHHDATHoDk7NSUcQ
         nZn2bbhEpA6HROEnI0HhaKbWpFLFvs0fb/KcibhOuvVPpiQtAZ4SLHuG/2YlS//AqN01
         HBTpFhfSnsrpR1VPhPGECEgS8CEfHW/XGmsFJn1qTPWb+twT2yPmKFfceuw6N6bcxiMV
         a1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058277; x=1688650277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu495ErLblvkCqCHGMpwun0U7rLfauxkN4tFcXNAkpw=;
        b=WsJznmCEfon8q/mGGoHoGtfs1fHrgJf9n+zpANcLkHMZOp8TS60Do80HtdKMzuTxy4
         6n8mGAxG/5wSstxY3FZei1p/6R3ajhbk6HqDB7Ifiv/3+pVrnUaUSEcrxvJUtp0qHvk1
         x6QW5Ua8BEAi6j0Euxa7OwQptks1GPxYO3I8NAJlTqePX2v1RcigSIqvK7LNbJqFYdct
         FLnadv0JtOsVWZuz1Psrbl0DnxcNUCnCNH40wDEj+QjMbJMlb2VnfUhzVqRTE1Z4N0HD
         I2Z3Ds4etsiy/pIKn7/28Y/H31idJ68U/ex2tIn4lhxxbOtn0oY/+Mya4rYh1VHVQx+Z
         LWmw==
X-Gm-Message-State: AC+VfDw8jBMUHnhtFo1CiZBiflEPutkAbp+Oh1ucqk6ZetxpHIfd6/7n
        z6dPFlzlRs6ZwkBOiKQfaxiyAucrxJoyjtoljtEbpA==
X-Google-Smtp-Source: ACHHUZ4isNWVrrmujDaPy3+ZYSGLOkgJc0Ej3Az+fuKIjZ41gu7zyhXeEtL1cSeOol6y9dg5oeQ8vOkzAm3oYWUsSO8=
X-Received: by 2002:a05:622a:1a20:b0:3f9:b81c:3a0f with SMTP id
 f32-20020a05622a1a2000b003f9b81c3a0fmr7430qtb.17.1686058277351; Tue, 06 Jun
 2023 06:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-8-peternewman@google.com> <3816ccf6-4f74-6406-5ca0-580743efa2a1@intel.com>
 <CALPaoCj76eMTF+VPT8_52_D+fKpWt2ENcyavJ4aooCOo9TYKFw@mail.gmail.com> <00b0c70d-eed8-8dc1-8046-25764d991bf4@intel.com>
In-Reply-To: <00b0c70d-eed8-8dc1-8046-25764d991bf4@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 6 Jun 2023 15:31:06 +0200
Message-ID: <CALPaoCgTmGWZH-d40OPFJ9txWKfXfxVRYG_VQPeo5pb_6vci_A@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
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

On Wed, May 17, 2023 at 2:06=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 5/16/2023 7:49 AM, Peter Newman wrote:
> > On Thu, May 11, 2023 at 11:40=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> I do not see any impact to the (soft) RMIDs that can be assigned to mo=
nitor
> >> groups, yet from what I understand a generic "RMID" is used as index t=
o MBM state.
> >> Is this correct? A hardware RMID and software RMID would thus share th=
e
> >> same MBM state. If this is correct I think we need to work on making
> >> the boundaries between hard and soft RMID more clear.
> >
> > The only RMID-indexed state used by soft RMIDs right now is
> > mbm_state::soft_rmid_bytes. The other aspect of the boundary is
> > ensuring that nothing will access the hard RMID-specific state for a
> > soft RMID.
> >
> > The remainder of the mbm_state is only accessed by the software
> > controller, which you suggested that I disable.
> >
> > The arch_mbm_state is accessed only through resctrl_arch_rmid_read()
> > and resctrl_arch_reset_rmid(), which are called by __mon_event_count()
> > or the limbo handler.
> >
> > __mon_event_count() is aware of soft RMIDs, so I would just need to
> > ensure the software controller is disabled and never put any RMIDs on
> > the limbo list. To be safe, I can also add
> > WARN_ON_ONCE(rdt_mon_soft_rmid) to the rmid-indexing of the mbm_state
> > arrays in the software controller and before the
> > resctrl_arch_rmid_read() call in the limbo handler to catch if they're
> > ever using soft RMIDs.
>
> I understand and trust that you can ensure that this implementation is
> done safely. Please also consider how future changes to resctrl may stumb=
le
> if there are not clear boundaries. You may be able to "ensure the softwar=
e
> controller is disabled and never put any RMIDs on the limbo list", but
> consider if these rules will be clear to somebody who comes along in a ye=
ar
> or more.
>
> Documenting the data structures with these unique usages will help.
> Specific accessors can sometimes be useful to make it obvious in which st=
ate
> the data is being accessed and what data can be accessed. Using WARN
> as you suggest is a useful tool.

After studying the present usage of RMID values some more, I've
concluded that I can cleanly move all knowledge of the soft RMID
implementation to be within resctrl_arch_rmid_read() and that none of
the FS-layer code should need to be aware of them. However, doing this
would require James's patch to allow resctrl_arch_rmid_read() to
block[1], since resctrl_arch_rmid_read() would be the first
opportunity architecture-dependent code has to IPI the other CPUs in
the domain.

The alternative to blocking in resctrl_arch_rmid_read() would be
introducing an arch hook to mon_event_read(), where blocking can be
done today without James's patches, so that architecture-dependent
code can IPI all CPUs in the target domain to flush their event counts
to memory before calling mon_event_count() to total their MBM event
counts.

The remaining special case for soft RMIDs would be knowing that they
should never go on the limbo list. Right now I've hard-coded the soft
RMID read to always return 0 bytes for occupancy events, but this
answer is only correct in the context of deciding whether RMIDs are
dirty, so I have to prevent the events from being presented to the
user. If returning an error wasn't considered "dirty", maybe that
would work too.

Maybe the cleanest approach would be to cause enabling soft RMIDs to
somehow cause is_llc_occupancy_enabled() to return false, but this is
difficult as long as soft RMIDs are configured at mount time and
rdt_mon_features is set at boot time. If soft RMIDs move completely
into the arch layer, is it preferable to configure them with an rdt
boot option instead of adding an architecture-dependent mount option?
I recall James being opposed to adding a boot option for this.

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/20230525180209.19497-15-james.morse@arm.co=
m/
