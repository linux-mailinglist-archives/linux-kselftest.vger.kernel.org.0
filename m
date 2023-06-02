Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5B72024E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjFBMmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjFBMmz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 08:42:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6A196
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 05:42:53 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso213331cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685709772; x=1688301772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JCTvniZ12mr+m+9b8RtDFwDRmM7sUAnvwKqhY7Pabw=;
        b=sm13f6K2f8Fb1b27q819RtEObuwO6Dn+jj3C81BOG8A0rgXFLXg02UJxkBnqunFpEQ
         MwvFGvQBhy7JhvE+/50TABk2lqxlCmVlB/OjHzw+rYI7vwSthAihNrIwVEgmcy5fr+F4
         nf/idPVXHFhINwULTGV5eeid5SKHI4AlQwczeTmvTaYMbFfPIvFWirhr9JHap2dqr7nr
         xFm2mxTCbsHXgndL95QoNq7t/hgXtMW3Hj/sMHz5KWwE5XAPn7fgkoDanPXGQxHYbbv8
         YTCx1JSG4Fj8TChtKRbnR6bJkkN2qonAFIkrikDd372VB6jj/iV4Kpjhk6lFj53wr3gc
         UE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709772; x=1688301772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JCTvniZ12mr+m+9b8RtDFwDRmM7sUAnvwKqhY7Pabw=;
        b=ZgxrKT+GvnC4GZ0QWsQi8cPFFBOiDd9tbIWJCU95I03hOjhekemLnLBIZYFK9i9P/9
         op3DMrI6PSXkAXmxbusNCl+0dATXoV9DlhXES8yOsITitIgfJvuSrUIb50vAB6jYVTUV
         5orblTYe1tsM2gaOks9ul1RW8xNc4QmE+WHp14gFydsdPxflAwA4Wj8O0RSLetdi4ig+
         ZAi9BKvbHC50/ivjsw6wU5KDcenBRcw03Gm4Zq9ZjVnTBVJQQabhvoCIqS9Bp/OCgF1y
         cGYEVI8jmFh6qtrLlcFGiIFY8xstCiNGCmFToz7JWUAadIzTHXklN+8hctXJnwoUAcKO
         9GGA==
X-Gm-Message-State: AC+VfDyDsTzALXyFVyPhJ9RC20pbpeE4zEY65Os9ai6IeeocIipjmNTO
        um1nd1YWr/todxAmROJpQb6TuyV9NvI2GsfsVNPqLQ==
X-Google-Smtp-Source: ACHHUZ45RXhxoQvn5SzZNHD16ojn6LjWG4pZNYIxIujy/hJ+5sqvE6H0YdN3WyjGCLOFnFD3CIG0D1c/qLQnMfevDUk=
X-Received: by 2002:a05:622a:91:b0:3f8:1db6:201c with SMTP id
 o17-20020a05622a009100b003f81db6201cmr161246qtw.13.1685709772498; Fri, 02 Jun
 2023 05:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-9-peternewman@google.com> <c27972ef-1b17-36dd-50b8-790f7994733f@intel.com>
In-Reply-To: <c27972ef-1b17-36dd-50b8-790f7994733f@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 2 Jun 2023 14:42:41 +0200
Message-ID: <CALPaoCjQkZvW+11KV+j23EiY8EV=rV6ai6pCVBR+=6SdS24KOg@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] x86/resctrl: Use mbm_update() to push soft RMID counts
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
> >       list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> > -             mbm_update(r, d, prgrp->mon.rmid);
> > +             /*
> > +              * mbm_update() on every RMID would result in excessive I=
PIs
> > +              * when RMIDs are soft.
> > +              */
> > +             if (!rdt_mon_soft_rmid) {
> > +                     mbm_update(r, d, prgrp->mon.rmid);
> >
> > -             head =3D &prgrp->mon.crdtgrp_list;
> > -             list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> > -                     mbm_update(r, d, crgrp->mon.rmid);
> > +                     head =3D &prgrp->mon.crdtgrp_list;
> > +                     list_for_each_entry(crgrp, head, mon.crdtgrp_list=
)
> > +                             mbm_update(r, d, crgrp->mon.rmid);
> > +             }
> >
> >               if (is_mba_sc(NULL))
> >                       update_mba_bw(prgrp, d);
>
>
> hmmm ... I think that update_mba_bw() relies on mbm_update() to call
> mbm_bw_count() to update the data it depends on. Keeping update_mba_bw()
> while dropping mbm_update() thus seems problematic. AMD does not support =
the
> software controller though so it may make things simpler if support for
> software RMIDs disables support for software controller (in a clear way).

I looked over this again and realized that the rationale for skipping
mbm_update() in this patch is incorrect.
__mon_event_count_soft_rmid() does not send any IPIs, so it's
perfectly fine to call mbm_update() and update_mba_bw() when using
soft RMIDs.

Even if we don't use the software controller on AMD, it seems
conceptually cleaner to just allow soft and hard RMIDs to be used
interchangeably wherever they work.

-Peter
