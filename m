Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56D705138
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjEPOt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjEPOtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 10:49:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0C10EC
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:49:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f38824a025so1826881cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684248564; x=1686840564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOyuxQWRj7mBxcG4uzXJBTcD+VFjWgiMqfEKYgz0FxE=;
        b=Lz0TiqncdRoXeVjHg44OrLFE2qLcXpMeVi+QvnvDEREwT9C5xa+IqBu3GpPJCqw/Q2
         CvlsVAr7+c0jqQC6ixXNANzKotTrwahGzP3+29GAM9ONPuJ7OWs8jSoRbhD2was1U3n+
         lq3Y3ZwbsHYzT7dydr5i4WwmqlaNitZcKehrbdbtUk8DNeVT6/wJpMlnArEPxJpE+LQW
         H9wGLfgaZVg0P6YGffsllV7wPquF4UpgSo32ORWhhZCX/blykpQ8/Dyw9yiLslVYoylD
         E9/uqMDbmSjtjYCyzQ6bWrs0qRSNfZG6nldBlho4sNyOqiyEAcrfscCpm3D/+lcafV0f
         JnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684248564; x=1686840564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOyuxQWRj7mBxcG4uzXJBTcD+VFjWgiMqfEKYgz0FxE=;
        b=Fu/FieXEKlhNrQlprcnmTe4p8hdJk0j7sWczexMbZhuguolhzbXf3/T/3+crQljPjs
         Fgjv/AdJByfs1yzOStpoofNKuUk+Kg9TSsjt1Lj2nsTAnbG6Ayb825er883jns50Bn8q
         w4+B/o8mj+9sKgx01swVbw2NQ+/qVukexQfzwiS+rOtX0Sy0fqeB8FU9Q8Pi1XP3RktO
         bmlxfuymVToyCItx31UAJTt7nE83Tfw912iQU2nFLVXFr6OBvY2l1mpcUrRFJZw+MpSP
         esbRtvPHVR6rzRARfzAR2ysuHJF+cFd/Xe8lLJbOjHea04tsEvPkUDMl1j+CrIthp2qL
         sw4w==
X-Gm-Message-State: AC+VfDzRB60osGbkmApZ641cs41G7EuZI6IdGF+WnevKIh14lo1WcC0v
        2h4wkk6oB96IkiF3XTA6klUnEpc893zmMY2DkqkKrw==
X-Google-Smtp-Source: ACHHUZ5Yx61E/0FENVw2X66LL20VU83PcKIKc/B5iWAVRpCnrBdFVFUdFJqIPdT+Gyld7wf+dHsBbFnV8b1PCO4uHwc=
X-Received: by 2002:a05:622a:1a24:b0:3bf:e4e0:26a0 with SMTP id
 f36-20020a05622a1a2400b003bfe4e026a0mr368805qtb.14.1684248563679; Tue, 16 May
 2023 07:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-8-peternewman@google.com> <3816ccf6-4f74-6406-5ca0-580743efa2a1@intel.com>
In-Reply-To: <3816ccf6-4f74-6406-5ca0-580743efa2a1@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 16 May 2023 16:49:10 +0200
Message-ID: <CALPaoCj76eMTF+VPT8_52_D+fKpWt2ENcyavJ4aooCOo9TYKFw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Thu, May 11, 2023 at 11:40=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 4/21/2023 7:17 AM, Peter Newman wrote:
> > +     /* Locate the cacheinfo for this CPU's L3 cache. */
> > +     for (i =3D 0; i < ci->num_leaves; i++) {
> > +             if (ci->info_list[i].level =3D=3D 3 &&
> > +                 (ci->info_list[i].attributes & CACHE_ID)) {
> > +                     l3ci =3D &ci->info_list[i];
> > +                     break;
> > +             }
> > +     }
> > +     WARN_ON(!l3ci);
> > +
> > +     if (!l3ci)
> > +             return 0;
>
> You can use "if (WARN_ON(..))"

Thanks, I'll look for the other changes in the series which would
benefit from this.


> > +     rmid =3D 0;
> > +     for_each_cpu(i, &l3ci->shared_cpu_map) {
> > +             if (i =3D=3D cpu)
> > +                     break;
> > +             rmid++;
> > +     }
> > +
> > +     return rmid;
> > +}
>
> I do not see any impact to the (soft) RMIDs that can be assigned to monit=
or
> groups, yet from what I understand a generic "RMID" is used as index to M=
BM state.
> Is this correct? A hardware RMID and software RMID would thus share the
> same MBM state. If this is correct I think we need to work on making
> the boundaries between hard and soft RMID more clear.

The only RMID-indexed state used by soft RMIDs right now is
mbm_state::soft_rmid_bytes. The other aspect of the boundary is
ensuring that nothing will access the hard RMID-specific state for a
soft RMID.

The remainder of the mbm_state is only accessed by the software
controller, which you suggested that I disable.

The arch_mbm_state is accessed only through resctrl_arch_rmid_read()
and resctrl_arch_reset_rmid(), which are called by __mon_event_count()
or the limbo handler.

__mon_event_count() is aware of soft RMIDs, so I would just need to
ensure the software controller is disabled and never put any RMIDs on
the limbo list. To be safe, I can also add
WARN_ON_ONCE(rdt_mon_soft_rmid) to the rmid-indexing of the mbm_state
arrays in the software controller and before the
resctrl_arch_rmid_read() call in the limbo handler to catch if they're
ever using soft RMIDs.

-Peter



>
> > +
> >  static void clear_closid_rmid(int cpu)
> >  {
> >       struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
> > @@ -604,7 +636,12 @@ static void clear_closid_rmid(int cpu)
> >       state->default_rmid =3D 0;
> >       state->cur_closid =3D 0;
> >       state->cur_rmid =3D 0;
> > -     wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> > +     state->hw_rmid =3D 0;
> > +
> > +     if (static_branch_likely(&rdt_soft_rmid_enable_key))
> > +             state->hw_rmid =3D determine_hw_rmid_for_cpu(cpu);
> > +
> > +     wrmsr(MSR_IA32_PQR_ASSOC, state->hw_rmid, 0);
> >  }
> >
> >  static int resctrl_online_cpu(unsigned int cpu)
>
> Reinette
