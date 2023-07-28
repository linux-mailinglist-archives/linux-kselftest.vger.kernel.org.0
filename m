Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E0767273
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjG1QyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjG1QxB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:53:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5883E49ED
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 09:51:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5fc972760eso2060663276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690563084; x=1691167884;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSztq2dvrAtj1uS3ESiNs+Jg1HePYMDsZwSdft0wsVY=;
        b=uC9D4FcQ4hwzphsSwJRgDNbPH7AACt801Mlm2IGAsaCpAbFm8nZ/5u79Nw0s7R6uTN
         S0AqDXgmdZcN9sqoD6w3I4W2sdk/FkYcC/gwy7cQgo0LGGfDS5+9+Sm0owWE9jYCC8TN
         TmtJK10RK9ulRo6V6oV6oDwYY1nnMo3vfgBGy0Ozsi9gIkswPMzDAjG+jewR7raXO+P3
         95CCiOUHijIqyJXPUFIHEmwBnCL9VRYUEvCY5LGHTJHB32w4QIzGmnk+/XdJM1+8eN8Y
         +AgjzUEjfZ/EFu/piAU2X3fpKgrpzv3rT9tuambFkZRwDttE7wnctxSipbS5Ay9LyUoi
         1piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563084; x=1691167884;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hSztq2dvrAtj1uS3ESiNs+Jg1HePYMDsZwSdft0wsVY=;
        b=atLQ0z75xUtGSrHSu5brWXA/1zs5+ydHRrQzhRFV6SoMgAujZn07ic3qMJBcNvOgmG
         7rW8PEZubks22pUwccbckdLdbsuI5YbV5IT/NqlSScTgxl3+wIcf2AeztgFdFEkJ3aUO
         GY6wQisMiE73BxKgr6c9PKdhOFG4mjINYH9rLT6Z0k7cqk0l9AnmwATtOWWEXreW7kfU
         WifQk/+M8vofIkhovNUL3xPttPc9DAYrfpKjavRT5d2owrhwA/tJOl+eDOFKfmPPuhC5
         iAkDPWKFg6WKGYr7nreBTd0+VQmIFrLNjxoc//N08dq01/B6hitfCCKrtv3vwsDRSPe8
         mZ4A==
X-Gm-Message-State: ABy/qLYSzWXBCa5EwoempIY6YuVw3PAtdZETPjWSGll9RMcLh0E1nVAs
        JVmS5dG0dNIo/W2N+wwWn9oAbEs=
X-Google-Smtp-Source: APBJJlEi55DECGldnh4oz+7pIZRoVzrzq1k+o9LpkI1MyKXobMp3xALP+1XPqinyyja4f6VBX3Vg0pc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:f89:0:b0:d0b:c67:de3b with SMTP id
 131-20020a250f89000000b00d0b0c67de3bmr13938ybp.13.1690563084070; Fri, 28 Jul
 2023 09:51:24 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:51:22 -0700
In-Reply-To: <1023fdeb-a45a-2e9e-cd2e-7e44e655e8fc@tessares.net>
Mime-Version: 1.0
References: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
 <CAHC9VhS_LKdkEmm5_J5y34RpaRcTbg8==fpz8pMThDCjF6nYtQ@mail.gmail.com>
 <b41babb1-f0f2-dc2f-c2e3-1870107fbd9f@tessares.net> <ZMKxC+CFj4GbCklg@google.com>
 <1023fdeb-a45a-2e9e-cd2e-7e44e655e8fc@tessares.net>
Message-ID: <ZMPyCt2uozns776Q@google.com>
Subject: Re: [RFC bpf-next v5] bpf: Force to MPTCP
From:   Stanislav Fomichev <sdf@google.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/28, Matthieu Baerts wrote:
> Hi Stanislav,
>=20
> On 27/07/2023 20:01, Stanislav Fomichev wrote:
> > On 07/27, Matthieu Baerts wrote:
> >> Hi Paul, Stanislav,
> >>
> >> On 18/07/2023 18:14, Paul Moore wrote:
> >>> On Tue, Jul 18, 2023 at 11:21=E2=80=AFAM Geliang Tang <geliang.tang@s=
use.com> wrote:
> >>>>
> >>>> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]=
:
> >>>>
> >>>> "Your app can create sockets with IPPROTO_MPTCP as the proto:
> >>>> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> >>>> forced to create and use MPTCP sockets instead of TCP ones via the
> >>>> mptcpize command bundled with the mptcpd daemon."
> >>>>
> >>>> But the mptcpize (LD_PRELOAD technique) command has some limitations
> >>>> [2]:
> >>>>
> >>>>  - it doesn't work if the application is not using libc (e.g. GoLang
> >>>> apps)
> >>>>  - in some envs, it might not be easy to set env vars / change the w=
ay
> >>>> apps are launched, e.g. on Android
> >>>>  - mptcpize needs to be launched with all apps that want MPTCP: we c=
ould
> >>>> have more control from BPF to enable MPTCP only for some apps or all=
 the
> >>>> ones of a netns or a cgroup, etc.
> >>>>  - it is not in BPF, we cannot talk about it at netdev conf.
> >>>>
> >>>> So this patchset attempts to use BPF to implement functions similer =
to
> >>>> mptcpize.
> >>>>
> >>>> The main idea is add a hook in sys_socket() to change the protocol i=
d
> >>>> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> >>>>
> >>>> [1]
> >>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
> >>>> [2]
> >>>> https://github.com/multipath-tcp/mptcp_net-next/issues/79
> >>>>
> >>>> v5:
> >>>>  - add bpf_mptcpify helper.
> >>>>
> >>>> v4:
> >>>>  - use lsm_cgroup/socket_create
> >>>>
> >>>> v3:
> >>>>  - patch 8: char cmd[128]; -> char cmd[256];
> >>>>
> >>>> v2:
> >>>>  - Fix build selftests errors reported by CI
> >>>>
> >>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> >>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >>>> ---
> >>>>  include/linux/bpf.h                           |   1 +
> >>>>  include/linux/lsm_hook_defs.h                 |   2 +-
> >>>>  include/linux/security.h                      |   6 +-
> >>>>  include/uapi/linux/bpf.h                      |   7 +
> >>>>  kernel/bpf/bpf_lsm.c                          |   2 +
> >>>>  net/mptcp/bpf.c                               |  20 +++
> >>>>  net/socket.c                                  |   4 +-
> >>>>  security/apparmor/lsm.c                       |   8 +-
> >>>>  security/security.c                           |   2 +-
> >>>>  security/selinux/hooks.c                      |   6 +-
> >>>>  tools/include/uapi/linux/bpf.h                |   7 +
> >>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 +++++++++++++++=
+--
> >>>>  tools/testing/selftests/bpf/progs/mptcpify.c  |  17 +++
> >>>>  13 files changed, 187 insertions(+), 23 deletions(-)
> >>>>  create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> >>>
> >>> ...
> >>>
> >>>> diff --git a/security/security.c b/security/security.c
> >>>> index b720424ca37d..bbebcddce420 100644
> >>>> --- a/security/security.c
> >>>> +++ b/security/security.c
> >>>> @@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
> >>>>   *
> >>>>   * Return: Returns 0 if permission is granted.
> >>>>   */
> >>>> -int security_socket_create(int family, int type, int protocol, int =
kern)
> >>>> +int security_socket_create(int *family, int *type, int *protocol, i=
nt kern)
> >>>>  {
> >>>>         return call_int_hook(socket_create, 0, family, type, protoco=
l, kern);
> >>>>  }
> >>>
> >>> Using the LSM to change the protocol family is not something we want
> >>> to allow.  I'm sorry, but you will need to take a different approach.
> >>
> >> @Paul: Thank you for your feedback. It makes sense and I understand.
> >>
> >> @Stanislav: Despite the fact the implementation was smaller and reusin=
g
> >> more code, it looks like we cannot go in the direction you suggested. =
Do
> >> you think what Geliang suggested before in his v3 [1] can be accepted?
> >>
> >> (Note that the v3 is the same as the v1, only some fixes in the selfte=
sts.)
> >=20
> > We have too many hooks in networking, so something that doesn't add
> > a new one is preferable :-(
>=20
> Thank you for your reply and the explanation, I understand.
>=20
> > Moreover, we already have a 'socket init' hook, but it runs a bit late.
>=20
> Indeed. And we cannot move it before the creation of the socket.
>=20
> > Is existing cgroup/sock completely unworkable? Is it possible to
> > expose some new bpf_upgrade_socket_to(IPPROTO_MPTCP) kfunc which would
> > call some new net_proto_family->upgrade_to(IPPROTO_MPTCP) to do the sur=
gery?
> > Or is it too hacky?
>=20
> I cannot judge if it is too hacky or not but if you think it would be
> OK, please tell us :)

Maybe try and see how it goes? Doing the surgery to convert from tcp
to mptcp is probably hard, but it seems that we should be able to
do something like:

int upgrade_to(sock, sk) {
	if (sk is not a tcp one) return -EINVAL;

	sk_common_release(sk);
	return inet6_create(net, sock, IPPROTO_MPTCP, false);
}

?

The only thing I'm not sure about is whether you can call inet6_create
on a socket that has seen sk_common_release'd...
=20
> > Another option Alexei suggested is to add some fentry-like thing:
> >=20
> > noinline int update_socket_protocol(int protocol)
> > {
> > 	return protocol;
> > }
> > /* TODO: ^^^ add the above to mod_ret set */
> >=20
> > int __sys_socket(int family, int type, int protocol)
> > {
> > 	...
> >=20
> > 	protocol =3D update_socket_protocol(protocol);
> >=20
> > 	...
> > }
> >=20
> > But it's also too problem specific it seems? And it's not cgroup-aware.
>=20
> It looks like it is what Geliang did in his v6. If it is the only
> acceptable solution, I guess we can do without cgroup support. We can
> continue the discussions in his v6 if that's easier.

Ack, that works too, let's see how other people feel about it. I'm
assuming in the bpf program we can always do bpf_get_current_cgroup_id()
to filter by cgroup.
