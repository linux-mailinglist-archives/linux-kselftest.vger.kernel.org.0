Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA364DF17
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLOQ4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Dec 2022 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLOQ4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Dec 2022 11:56:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C6F582
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 08:56:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt4so11126993pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOs+4sldiwGC1XG54dp5mVgT4uLPOQwpbZy8XgG5P7U=;
        b=BwAd8aLPF5gd7FIHoISnAe0Zyh/n9acpz7ASV5bArM8hi+12M+FokUGMCFBYex8YYT
         nxAxlAOtheavS0XJFp986uZEh6iP0Ge1ESokWEFBokuizRQABamacozxfHoHFFmuc1ig
         og9sJEbM9bDah05cislLrAkqozwsfBmeI2c0IATzpQQH3Shewyh+bhXQoOzGvx/VhhF4
         q0IchDuQ9ETeLCwyhWh4KMyKbH1/EIDfepr0bi0OHiqJSTjhJ7A3Nxt8kXYoynQWbMgP
         NFZaNJrEnOv3E7GDTrJU47AoUmR++UPFYGrV0RFmWai23NVv2rwcyUqZetoHP0TjnvhP
         tb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOs+4sldiwGC1XG54dp5mVgT4uLPOQwpbZy8XgG5P7U=;
        b=du0cqnsClqwzHU/yR0J71j9IPUTTq2M3cxnoqYcyeWJsFwYr/iI+K8DqnT4D5Ag0/4
         FCSCi9XKSKxtGCB/XucoD1/JCBhSuq7uOJd2g9PWFF/oqPKJ4s39tbfTtbJHWlWPvg0t
         ws+dHwn0dC2IZM4FDfECfEZU5+GTzjdtg4/uZ+GXwz13Zkb3z7+JTkCFxMZ+bOyNI/an
         n1zi3A/0/UnkucXOsgcvB9RruSBg+U6iWEYcRszf2ckPhxkj6NcHr0Bqrh/QVsPh8WKw
         xlBbq4gWz723j/085l6iI3RRbPitIadn7OdnT2QxSwlpTJpk/6+VQZp5AjLn7gwkq2vU
         pfLg==
X-Gm-Message-State: AFqh2krDF5oyfiE4knVFYy8Nwliep5sSEGUmKdCjXPXLUOSJZV6DueDW
        wmapJCW2cB9JZwiSYdH510MMvAW28y34o0nmwQv5zg==
X-Google-Smtp-Source: AMrXdXtENt/mhPma/+EbgzmxkFLEmcOUooUWEz4dux8uEyqEYR9PwvfNgIzmFBek41FGvcb4TrN/AF2YjFTKl7rw3wI=
X-Received: by 2002:a17:90a:4612:b0:219:a43b:1006 with SMTP id
 w18-20020a17090a461200b00219a43b1006mr786360pjg.195.1671123363557; Thu, 15
 Dec 2022 08:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <202212141053.7F5D1F6@keescook>
 <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com> <202212141607.D2D986C076@keescook>
In-Reply-To: <202212141607.D2D986C076@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 15 Dec 2022 08:55:26 -0800
Message-ID: <CALmYWFvJv_4yLxnv=8Bpx0mE_WLi0yGVxR-ybN8VAatEwmM+iQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, jeffxu@chromium.org,
        skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 14, 2022 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 14, 2022 at 03:32:16PM -0800, Jeff Xu wrote:
> > On Wed, Dec 14, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrot=
e:
> > >
> > > On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > Since Linux introduced the memfd feature, memfd have always had the=
ir
> > > > execute bit set, and the memfd_create() syscall doesn't allow setti=
ng
> > > > it differently.
> > > >
> > > > However, in a secure by default system, such as ChromeOS, (where al=
l
> > > > executables should come from the rootfs, which is protected by Veri=
fied
> > > > boot), this executable nature of memfd opens a door for NoExec bypa=
ss
> > > > and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP =
bug [1]: cros_vm
> > > > process created a memfd to share the content with an external proce=
ss,
> > > > however the memfd is overwritten and used for executing arbitrary c=
ode
> > > > and root escalation. [2] lists more VRP in this kind.
> > > >
> > > > On the other hand, executable memfd has its legit use, runc uses me=
mfd=E2=80=99s
> > > > seal and executable feature to copy the contents of the binary then
> > > > execute them, for such system, we need a solution to differentiate =
runc's
> > > > use of  executable memfds and an attacker's [3].
> > > >
> > > > To address those above, this set of patches add following:
> > > > 1> Let memfd_create() set X bit at creation time.
> > > > 2> Let memfd to be sealed for modifying X bit.
> > > > 3> A new pid namespace sysctl: vm.memfd_noexec to control the behav=
ior of
> > > >    X bit.For example, if a container has vm.memfd_noexec=3D2, then
> > > >    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > > > 4> A new security hook in memfd_create(). This make it possible to =
a new
> > > > LSM, which rejects or allows executable memfd based on its security=
 policy.
> > >
> > > I think patch 1-5 look good to land. The LSM hook seems separable, an=
d
> > > could continue on its own. Thoughts?
> > >
> > Agreed.
> >
> > > (Which tree should memfd change go through?)
> > >
> > I'm not sure, is there a recommendation ?
>
> It looks like it's traditionally through akpm's tree. Andrew, will you
> carry patches 1-5?
>
Hi Andrew, if you are taking this, V8 is the latest that contains patch 1-5=
.

Thanks
Jeff

> Thanks!
>
> --
> Kees Cook
