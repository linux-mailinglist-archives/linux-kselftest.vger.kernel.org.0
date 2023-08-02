Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E276D838
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 21:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHBTzE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHBTzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 15:55:03 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CB71BD5
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 12:55:01 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcb15aa074so186668a34.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691006101; x=1691610901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fk7IVszVGEX05tlsz3xS9WSAYRKj6iRdkz3X4m9LLk=;
        b=a4r1NIwyeNPmYaRDUwHG6QqlAcxCuWFkiQ9bjYob7bVbJcmYh8bb+iFKflVUDLPSTL
         Dmp1/X7VacHvPtUaNtg/dVJpdgr/HgUZPNCEZgECbUr+47se3QuRhwsTi8iTMgoJm6Mu
         lyoUzhVLySE85gpxZc4Ev/+WQQWnkqwPq9FOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691006101; x=1691610901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fk7IVszVGEX05tlsz3xS9WSAYRKj6iRdkz3X4m9LLk=;
        b=lnwtc6blq01WwwVHcMqw5dvJvchhx9zZy/BMkFF2191IokLSnN5iZITARWD3LjGpFM
         i5A7ysOUahTOfo027tp65vCYVzXJX0absLqY8YfIZkCsHasCkbGq8gw0DOtVLi2XcoEg
         BrcbS9siSADJURJyZNHyZcN1pm+Q+tYjgB6qhkgi1NHCekOVMc9u3T3qlI4ZKLdih7rF
         2AkP7HVJkSKorQIJqJY2sUCqguoWxgdVIi2vj45V3Oq3jY/WHO+nTZqshy/1VLeZiovI
         E7iq4VzFKwN16gUnLql9ofmm2cpAZrxrZ37Rj4kd5jwFbujpPPCaKMMjyqIMd2SmDZz1
         7cpg==
X-Gm-Message-State: ABy/qLb5Thl3ZM4GKlS/lt8T+TXLjrmI354S4hw3I1/bc9/DYUcTKc8W
        P2V3K7pkrFhZJhLLatLtRtA6UNVC3hc9Q89xpFq8ZA==
X-Google-Smtp-Source: APBJJlGu7kqV6VwbdzSfXnrVqjHk9QX7dxjnDkVK5xVnfSpyzukHJ2KYy3H9D73h3oD02/LXWWYZ+2w+tqBoa3LmXiA=
X-Received: by 2002:a9d:5a89:0:b0:6b8:b83c:a1f8 with SMTP id
 w9-20020a9d5a89000000b006b8b83ca1f8mr15064427oth.19.1691006100913; Wed, 02
 Aug 2023 12:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
 <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com> <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
In-Reply-To: <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Aug 2023 12:54:48 -0700
Message-ID: <CABi2SkXCsiz+WpPQc=iRjbq-Dp5XR-kDXcVg0A+HDu5Ddni6+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 2, 2023 at 12:47=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Tue, Aug 1, 2023 at 6:05=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> This thread is getting longer with different topics, I will try to
> respond with trimmed interleaved replies [1]
> There are 3 topics (logging/'migration/ratcheting), this response will
> be regarding ratcheting.
>
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l?highlight=3Dsigned%20off#use-trimmed-interleaved-replies-in-email-discuss=
ions
>
> >
> > > > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make se=
nse as a
> > > > > >    security mechanism because a CAP_SYS_ADMIN capable user can =
create
> > > > > >    executable binaries in a hidden tmpfs very easily, not to me=
ntion the
> > > > > >    many other things they can do.
> > > > > >
> > > > > By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> > > > > sysctl even after compromising some system service with high
> > > > > privilege, YAMA has the same approach for ptrace_scope=3D3
> > > >
> > > > Personally, I also think this behaviour from YAMA is a little goofy=
 too,
> > > > but given that it only locks the most extreme setting and there is =
no
> > > > way to get around the most extreme setting, I guess it makes some s=
ense
> > > > (not to mention it's an LSM and so there is an argument that it sho=
uld
> > > > be possible to lock out privileged users from modifying it).
> > > > There are many other security sysctls, and very few have this behav=
iour
> > > > because it doesn't make much sense in most cases.
> > > >
> > > > > In addition, this sysctl is pid_name spaced, this means child
> > > > > pid_namespace will alway have the same or stricter security setti=
ng
> > > > > than its parent, this allows admin to maintain a tree like view. =
If we
> > > > > allow the child pid namespace to elevate its setting, then the
> > > > > system-wide setting is no longer meaningful.
> > > >
> > > > "no longer meaningful" is too strong of a statement imho. It is sti=
ll
> > > > useful for constraining non-root processes and presumably ChromeOS
> > > > disallows random processes to do CLONE_NEWUSER (otherwise the prote=
ction
> > > > of this sysctl is pointless) so in practice for ChromeOS there is n=
o
> > > > change in the attack surface.
> > > >
> > > > (FWIW, I think tying this to the user namespace would've made more =
sense
> > > > since this is about privilege restrictions, but that ship has saile=
d.)
> > > >
> > > The reason that this sysctl is a PID namespace is that I hope a
> > > container and host can have different sysctl values, e.g. host will
> > > allow runc's use of X mfd, while a container  doesn't want X mfd. .
> > > To clarify what you meant, do you mean this: when a container is in
> > > its own pid_namespace, and has "=3D2", the programs inside the contai=
ner
> > > can still use CLONE_NEWUSER to break out "=3D2" ?
> >
> > With the current implementation, this is not possible. My point was tha=
t
> > even if it were possible to lower the sysctl, ChromeOS presumably
> > already blocks the operations that a user would be able to use to creat=
e
> > a memfd (an unprivileged user cannot CLONE_NEWPID to modify the sysctl
> > without CLONE_NEWUSER, which is presumably blocked on ChromeOS due to
> > the other security concerns).
> >
> >
> > > > > The code sample shared in this patch set indicates that the attac=
ker
> > > > > already has the ability of creating tmpfs and executing complex s=
teps,
> > > > > at that point, it doesn't matter if the code execution is from me=
mfd
> > > > > or not. For a safe by default system such as ChromeOS, attackers =
won't
> > > > > easily run arbitrary code, memfd is one of the open doors for tha=
t, so
> > > > > we are disabling executable memfd in ChromeOS. In other words:  i=
f an
> > > > > attacker can already execute the arbitrary code as sample given i=
n
> > > > > ChromeOS, without using executable memfd,  then memfd is no longe=
r the
> > > > > thing we need to worry about, the arbitrary code execution is alr=
eady
> > > > > achieved by the attacker. Even though I use ChromeOS as an exampl=
e, I
> > > > > think the same type of threat model applies to any system that wa=
nts
> > > > > to disable executable memfd entirely.
> > > >
> > > > I understand the threat model this sysctl is blocking, my point is =
that
> > > > blocking CAP_SYS_ADMIN from modifying the setting doesn't make sens=
e
> > > > from that threat model. An attacker that manages to trick some proc=
ess
> > > > into creating a memfd with an executable payload is not going to be=
 able
> > > > to change the sysctl setting (unless there's a confused deputy with
> > > > CAP_SYS_ADMIN, in which case you have much bigger issues).
> > > >
> > > It is the reverse.  An attacker that manages to trick some
> > > CAP_SYSADMIN processes into changing this sysctl value (i.e. lower th=
e
> > > setting to 0 if no ratcheting), will be able to continue to use mfd a=
s
> > > part of the attack chain.
> > >  In chromeOS, an attacker that can change sysctl might not necessaril=
y
> > > gain full arbitrary code execution already. As I mentioned previously=
,
> > > the main threat model here is to prevent  arbitrary code execution
> > > through mfd.  If an attacker already gains arbitrary code execution,
> > > at that point, we no longer worry about mfd.
> >
> > If an attacker can trick a privileged process into writing to arbitrary
> > sysctls, the system has much bigger issues than arbitrary (presumably
> > unprivileged) code execution. On the other hand, requiring you to reboo=
t
> > a server due to a misconfigured sysctl *is* broken.
> >
> > Again, at the very least, not even allowing capable(CAP_SYS_ADMIN) to
> > change the setting is actually broken.
> >
> > > > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blockin=
g it
> > > > doesn't add any security because that process could create a memfd-=
like
> > > > fd to execute without issues.
> > > >What practical attack does this ratcheting
> > > > mechanism protect against? (This is a question you can answer with =
the
> > > > YAMA sysctl, but not this one AFAICS.)
> > > >
> > > > But even if you feel that allowing this in child user namespaces is
> > > > unsafe or undesirable, it's absolutely necessary that
> > > > capable(CAP_SYS_ADMIN) should be able to un-brick the running syste=
m by
> > > > changing the sysctl. The alternative is that you need to reboot you=
r
> > > > server in order to un-set a sysctl that broke some application you =
run.
> > > >
> > >
> > > > Also, by the same token, this ratcheting mechanism doesn't make sen=
se
> > > > with =3D1 *at all* because it could break programs in a way that wo=
uld
> > > > require a reboot but it's not a "security setting" (and the YAMA sy=
sctl
> > > > mentioned only locks the sysctl at the highest setting).
> > > >
> > > I think a system should use "=3D0" when it is unsure about its progra=
m's
> > > need or not need executable memfd. Technically, it is not that this
> > > sysctl breaks the user, but the admin  made the mistake to set the
> > > wrong sysctl value, and an admin should know what they are doing for =
a
> > > sysctl. Yes. rebooting increases the steps to undo the mistake, but
> > > that could be an incentive for the admin to fully test its programs
> > > before turning on this sysctl - and avoid unexpected runtime errors.
> >
> > I don't think this stance is really acceptable -- if an admin that has
> > privileges to load kernel modules is not able to disable a sysctl that
> > can break working programs without rebooting there is
> >
> > When this sysctl was first proposed a few years ago (when kernel folks
> > found out that runc was using executable memfds), my understanding is
> > that the long-term goal was to switch programs to have
> > non-executable-memfds by default on most distributions. Making it
> > impossible for an admin to lower the sysctl value flies in the face of
> > this goal.
> >
> > At the very least, being unable to lower the sysctl from =3D1 to =3D0 i=
s
> > just broken (even if you use the yama example -- yama only locks the
> > sysctl at highest possible setting, not on lower settings). But in my
> > view, having this sysctl ratchet at all doesn't make sense.
> >
> To reiterate/summarize the current mechanism for vm.memfd_noexec
>
> 1> It is a pid namespace sysctl,  init ns and child pid ns can have
> different setting values.
> 2> child pid ns inherits parent's pid ns's sysctl at the time of fork.
> 3> There are  3 values for the sysctl, each higher value is more
> restrictive than the lower one. Once set, doesn't allow downgrading.
>
> It can be used as  following:
> 1>
> init ns: vm.memfd_noexec =3D 2 (at boot time)
> Not allow executable memfd for the entire system, including its container=
s.
>
> 2>
> init ns: vm.memfd_noexec =3D 0 or 1
> container (child init namespace) vm.memfd_noexec =3D 2.
> The host allows runc's usage of executable memfd during container
> creation. Inside the container, executable memfd is not allowed.
>
> The inherence + not allow downgrading is to reason with how
> vm.memfd_noexec is applied in the process tree.
> Without it, essentially we are losing the hierarchy view across the
> process tree and  a process can evaluate its capability by modifying
*elevate*
> the setting. I think that is a less secure approach I would not
> prefer.
>
> Thanks
>
> -Jeff
