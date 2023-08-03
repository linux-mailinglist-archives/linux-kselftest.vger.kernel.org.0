Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508C76ECE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjHCOmi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjHCOmX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:42:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9FF49F8
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 07:41:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso260291cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691073685; x=1691678485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ShBENNpfd+ej/Z7XuAdwo6IW6qOMuqNvx/9JpslxY4=;
        b=s5ZpE5m0z9BXLeriOh+7nPRPLhqXRRKn5iZFATBCfTAXWocOgUXQ62NUWrmwKzv9wF
         gVKc9xwOyq3UcexbeqzDlKJkPBkzs3Mw8AjS/rnCiEX8LvG+6c1g5tSIg/tdmjWWLqdW
         JtmhyMiw4nKfk7X0mD4bW2Z3VAxPJnfgAKY3z+3k9G2rwedwUCr60fRzqUYemQ4i9vnr
         htnfaMq1gC5ffcNGo/SQpST/Yr5ZnGV5J983X+fTGOabESW85OgdU8oSxIaWvAtM4TR+
         VkiA0zPvsx2yS1NGio0nsvfkttySjR03SmbwQl6NTkn3M/MQhTi4j8zhiOWBVMAq1Edl
         Uz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073685; x=1691678485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ShBENNpfd+ej/Z7XuAdwo6IW6qOMuqNvx/9JpslxY4=;
        b=Y/YlRbxs2l50WzMm+KSVsfBiUWOhUAl92DFM3tFkWCUhm+tbnMxt77rH6D8JScWPg8
         ZZOHkZWZgpA9HQUmTG0C479sWobuhEcURYsgad8z1eyGrdwRxo2M2X5ZNHxmMcFn6wLT
         g7QaTDMcpWmcTY0boDfJOxcNPsHmUVPzSL5Zdx7RQlp0QrPXBmrbQbtf39WBJLzm/U81
         qVD3q9PMWXwOonis4N6Cncedn8CM9er4t7bQ0HUsy8iCKINDaXBKXF8ygzNtjQA1Oh67
         HnXN2OChwOru3ouxzEjg+8wR08OQC5BkAtW63uy777uuetMBWSHofTpBPktgsrCakrXt
         R8zQ==
X-Gm-Message-State: ABy/qLaMpwdDW4ISY0KVqb6SxfOj+ZbPn12LewuyoOO8W0ozbCc/+jHC
        bixtPDVpeo4ufPwimdlNjm8jbaUr2mho9UfFZcLfYw==
X-Google-Smtp-Source: APBJJlGuNWoix/N0KU1hBW0OxkHI1UWTpOUCR1dXG41QDMR7tEB/2x44GxuWEnxTbceRyOmzYsfUY8dqAt9909stuko=
X-Received: by 2002:a05:622a:5cb:b0:403:f5b8:2bd2 with SMTP id
 d11-20020a05622a05cb00b00403f5b82bd2mr1210807qtb.9.1691073684458; Thu, 03 Aug
 2023 07:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
 <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
 <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
 <20230802.211829-obedient.verb.pointed.walk-inxghgNcxn@cyphar.com>
 <CALmYWFuahdUF7cT4cm7_TGLqPanuHXJ-hVSfZt7vpTnc18DPrw@mail.gmail.com> <20230803.043622-chrome.spruce.spotty.wine-lWgM90I146nT@cyphar.com>
In-Reply-To: <20230803.043622-chrome.spruce.spotty.wine-lWgM90I146nT@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 3 Aug 2023 07:40:48 -0700
Message-ID: <CALmYWFs6H+TnosKpedP7aF0pBLfBj2DCfcVPAuKaZPx7kKbO4g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Xu <jeffxu@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Aug 2, 2023 at 9:40=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2023-08-02, Jeff Xu <jeffxu@google.com> wrote:
> > On Wed, Aug 2, 2023 at 2:39=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> > >
> > > On 2023-08-02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > On Tue, Aug 1, 2023 at 6:05=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.=
com> wrote:
> > > > >
> > > > This thread is getting longer with different topics, I will try to
> > > > respond with trimmed interleaved replies [1]
> > > > There are 3 topics (logging/'migration/ratcheting), this response w=
ill
> > > > be regarding ratcheting.
> > >
> > > The migration and ratcheting topics are interconnected because the
> > > migration issue makes ratcheting an even more severe issue. But I'll
> > > respond to each thread separately.
> > >
> > > > [1] https://www.kernel.org/doc/html/latest/process/submitting-patch=
es.html?highlight=3Dsigned%20off#use-trimmed-interleaved-replies-in-email-d=
iscussions
> > > >
> > > > >
> > > > > > > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't m=
ake sense as a
> > > > > > > > >    security mechanism because a CAP_SYS_ADMIN capable use=
r can create
> > > > > > > > >    executable binaries in a hidden tmpfs very easily, not=
 to mention the
> > > > > > > > >    many other things they can do.
> > > > > > > > >
> > > > > > > > By further limiting CAP_SYS_ADMIN, an attacker can't modify=
 this
> > > > > > > > sysctl even after compromising some system service with hig=
h
> > > > > > > > privilege, YAMA has the same approach for ptrace_scope=3D3
> > > > > > >
> > > > > > > Personally, I also think this behaviour from YAMA is a little=
 goofy too,
> > > > > > > but given that it only locks the most extreme setting and the=
re is no
> > > > > > > way to get around the most extreme setting, I guess it makes =
some sense
> > > > > > > (not to mention it's an LSM and so there is an argument that =
it should
> > > > > > > be possible to lock out privileged users from modifying it).
> > > > > > > There are many other security sysctls, and very few have this=
 behaviour
> > > > > > > because it doesn't make much sense in most cases.
> > > > > > >
> > > > > > > > In addition, this sysctl is pid_name spaced, this means chi=
ld
> > > > > > > > pid_namespace will alway have the same or stricter security=
 setting
> > > > > > > > than its parent, this allows admin to maintain a tree like =
view. If we
> > > > > > > > allow the child pid namespace to elevate its setting, then =
the
> > > > > > > > system-wide setting is no longer meaningful.
> > > > > > >
> > > > > > > "no longer meaningful" is too strong of a statement imho. It =
is still
> > > > > > > useful for constraining non-root processes and presumably Chr=
omeOS
> > > > > > > disallows random processes to do CLONE_NEWUSER (otherwise the=
 protection
> > > > > > > of this sysctl is pointless) so in practice for ChromeOS ther=
e is no
> > > > > > > change in the attack surface.
> > > > > > >
> > > > > > > (FWIW, I think tying this to the user namespace would've made=
 more sense
> > > > > > > since this is about privilege restrictions, but that ship has=
 sailed.)
> > > > > > >
> > > > > > The reason that this sysctl is a PID namespace is that I hope a
> > > > > > container and host can have different sysctl values, e.g. host =
will
> > > > > > allow runc's use of X mfd, while a container  doesn't want X mf=
d. .
> > > > > > To clarify what you meant, do you mean this: when a container i=
s in
> > > > > > its own pid_namespace, and has "=3D2", the programs inside the =
container
> > > > > > can still use CLONE_NEWUSER to break out "=3D2" ?
> > > > >
> > > > > With the current implementation, this is not possible. My point w=
as that
> > > > > even if it were possible to lower the sysctl, ChromeOS presumably
> > > > > already blocks the operations that a user would be able to use to=
 create
> > > > > a memfd (an unprivileged user cannot CLONE_NEWPID to modify the s=
ysctl
> > > > > without CLONE_NEWUSER, which is presumably blocked on ChromeOS du=
e to
> > > > > the other security concerns).
> > > > >
> > > > >
> > > > > > > > The code sample shared in this patch set indicates that the=
 attacker
> > > > > > > > already has the ability of creating tmpfs and executing com=
plex steps,
> > > > > > > > at that point, it doesn't matter if the code execution is f=
rom memfd
> > > > > > > > or not. For a safe by default system such as ChromeOS, atta=
ckers won't
> > > > > > > > easily run arbitrary code, memfd is one of the open doors f=
or that, so
> > > > > > > > we are disabling executable memfd in ChromeOS. In other wor=
ds:  if an
> > > > > > > > attacker can already execute the arbitrary code as sample g=
iven in
> > > > > > > > ChromeOS, without using executable memfd,  then memfd is no=
 longer the
> > > > > > > > thing we need to worry about, the arbitrary code execution =
is already
> > > > > > > > achieved by the attacker. Even though I use ChromeOS as an =
example, I
> > > > > > > > think the same type of threat model applies to any system t=
hat wants
> > > > > > > > to disable executable memfd entirely.
> > > > > > >
> > > > > > > I understand the threat model this sysctl is blocking, my poi=
nt is that
> > > > > > > blocking CAP_SYS_ADMIN from modifying the setting doesn't mak=
e sense
> > > > > > > from that threat model. An attacker that manages to trick som=
e process
> > > > > > > into creating a memfd with an executable payload is not going=
 to be able
> > > > > > > to change the sysctl setting (unless there's a confused deput=
y with
> > > > > > > CAP_SYS_ADMIN, in which case you have much bigger issues).
> > > > > > >
> > > > > > It is the reverse.  An attacker that manages to trick some
> > > > > > CAP_SYSADMIN processes into changing this sysctl value (i.e. lo=
wer the
> > > > > > setting to 0 if no ratcheting), will be able to continue to use=
 mfd as
> > > > > > part of the attack chain.
> > > > > >  In chromeOS, an attacker that can change sysctl might not nece=
ssarily
> > > > > > gain full arbitrary code execution already. As I mentioned prev=
iously,
> > > > > > the main threat model here is to prevent  arbitrary code execut=
ion
> > > > > > through mfd.  If an attacker already gains arbitrary code execu=
tion,
> > > > > > at that point, we no longer worry about mfd.
> > > > >
> > > > > If an attacker can trick a privileged process into writing to arb=
itrary
> > > > > sysctls, the system has much bigger issues than arbitrary (presum=
ably
> > > > > unprivileged) code execution. On the other hand, requiring you to=
 reboot
> > > > > a server due to a misconfigured sysctl *is* broken.
> > > > >
> > > > > Again, at the very least, not even allowing capable(CAP_SYS_ADMIN=
) to
> > > > > change the setting is actually broken.
> > > > >
> > > > > > > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, b=
locking it
> > > > > > > doesn't add any security because that process could create a =
memfd-like
> > > > > > > fd to execute without issues.
> > > > > > >What practical attack does this ratcheting
> > > > > > > mechanism protect against? (This is a question you can answer=
 with the
> > > > > > > YAMA sysctl, but not this one AFAICS.)
> > > > > > >
> > > > > > > But even if you feel that allowing this in child user namespa=
ces is
> > > > > > > unsafe or undesirable, it's absolutely necessary that
> > > > > > > capable(CAP_SYS_ADMIN) should be able to un-brick the running=
 system by
> > > > > > > changing the sysctl. The alternative is that you need to rebo=
ot your
> > > > > > > server in order to un-set a sysctl that broke some applicatio=
n you run.
> > > > > > >
> > > > > >
> > > > > > > Also, by the same token, this ratcheting mechanism doesn't ma=
ke sense
> > > > > > > with =3D1 *at all* because it could break programs in a way t=
hat would
> > > > > > > require a reboot but it's not a "security setting" (and the Y=
AMA sysctl
> > > > > > > mentioned only locks the sysctl at the highest setting).
> > > > > > >
> > > > > > I think a system should use "=3D0" when it is unsure about its =
program's
> > > > > > need or not need executable memfd. Technically, it is not that =
this
> > > > > > sysctl breaks the user, but the admin  made the mistake to set =
the
> > > > > > wrong sysctl value, and an admin should know what they are doin=
g for a
> > > > > > sysctl. Yes. rebooting increases the steps to undo the mistake,=
 but
> > > > > > that could be an incentive for the admin to fully test its prog=
rams
> > > > > > before turning on this sysctl - and avoid unexpected runtime er=
rors.
> > > > >
> > > > > I don't think this stance is really acceptable -- if an admin tha=
t has
> > > > > privileges to load kernel modules is not able to disable a sysctl=
 that
> > > > > can break working programs without rebooting there is
> > > > >
> > > > > When this sysctl was first proposed a few years ago (when kernel =
folks
> > > > > found out that runc was using executable memfds), my understandin=
g is
> > > > > that the long-term goal was to switch programs to have
> > > > > non-executable-memfds by default on most distributions. Making it
> > > > > impossible for an admin to lower the sysctl value flies in the fa=
ce of
> > > > > this goal.
> > > > >
> > > > > At the very least, being unable to lower the sysctl from =3D1 to =
=3D0 is
> > > > > just broken (even if you use the yama example -- yama only locks =
the
> > > > > sysctl at highest possible setting, not on lower settings). But i=
n my
> > > > > view, having this sysctl ratchet at all doesn't make sense.
> > > > >
> > > > To reiterate/summarize the current mechanism for vm.memfd_noexec
> > > >
> > > > 1> It is a pid namespace sysctl,  init ns and child pid ns can have
> > > > different setting values.
> > > > 2> child pid ns inherits parent's pid ns's sysctl at the time of fo=
rk.
> > > > 3> There are  3 values for the sysctl, each higher value is more
> > > > restrictive than the lower one. Once set, doesn't allow downgrading=
.
> > > >
> > > > It can be used as  following:
> > > > 1>
> > > > init ns: vm.memfd_noexec =3D 2 (at boot time)
> > > > Not allow executable memfd for the entire system, including its con=
tainers.
> > > >
> > > > 2>
> > > > init ns: vm.memfd_noexec =3D 0 or 1
> > > > container (child init namespace) vm.memfd_noexec =3D 2.
> > > > The host allows runc's usage of executable memfd during container
> > > > creation. Inside the container, executable memfd is not allowed.
> > > >
> > > > The inherence + not allow downgrading is to reason with how
> > > > vm.memfd_noexec is applied in the process tree.
> > > > Without it, essentially we are losing the hierarchy view across the
> > > > process tree and  a process can evaluate its capability by modifyin=
g
> > > > the setting. I think that is a less secure approach I would not
> > > > prefer.
> > >
> > > If you really want the hierarchical aspect, we can implement it so th=
at
> > > it's _actually_ hierarchical like so:
> > >
> > >  * By default, your setting is the same as your parent (this is check=
ed
> > >    by going up the pidns tree -- a-la cgroups). This is less efficien=
t
> > >    but you want a hierarchy, so we can do it this way instead.
> > >  * If you set a specific setting, that takes precedence but only if i=
t's
> > >    a greater or equal setting to your parent.
> > >  * Trying to set a lower setting than your parent fails regardless of
> > >    privileges.
> > >
> > > This will allow *privileged users* to lower the setting, but only if
> > > the parent pidns also has a lower setting. This allows a system admin=
 to
> > > enforce the setting. It seems to me that this fulfils all the
> > > requirements you have.
> > >
> > > Most importantly, this would allow for a hierarchical view without
> > > having a sysctl that will break systems and nobody will use. I need t=
o
> > > re-iterate this point -- nobody is going to use this sysctl as it
> > > currently works because it ratchets in a way that admins cannot undo.=
 In
> > > practice this would mean you would need to reboot your whole datacent=
er
> > > if you didn't catch that an update to one of you dependencies didn't
> > > pass a required *noop* flag to memfd_create().
> > >
> > Yes. I agree this is another way to implement a hierarchical view,
> > which is a little more costly,  because it goes up the process tree.
>
> The maximum height is 32 namespaces, it's not that bad. I'm working on a
> v2 that implements it this way instead.
>
> I also just figured out that there is a flaw with the current
> implementation's "hierarchy" -- if you create a pid namespace and then
> change vm.memfd_noexec, the limit doesn't apply to the child pidns. This
> makes sense given the implementation, but it means that the "tree view"
> you talked about doesn't actually apply to your implementation.
>
That is by design.

The return on investment of implementing dynamic propagation isn't
high, i.e. vm.memfd_noexec  is  something that needs to be fully
tested before set and changing it at runtime is not recommended in
production,  downgrade requires reboot/restart.  On the host side, the
kernel cmd line now supports setting sysctl, and it can be applied
from boot time. These combined factors make me choose the current
implementation.
Simplicity is something I value greatly. feature richness can be
achieved, but sometimes with the cost of complexity.

> > I respectfully disagree that nobody will use the current sysctl
> > though, I can still see that a container might want this,  e.g. a
> > small container that doesn't require a lot of refactoring to add NX,
> > and restarting container usually isn't a problem, and container might
> > like the fact that downgrade is denied at run time.
>
> I should've specified that I was talking about using the setting on the
> host (which is presumably the goal -- at the very least I presume the
> goal is to get distributions to use =3D1 at some point).
>
> Also, funnily enough, container runtimes use executable memfds. :P
>
Yes. runc uses executable memfd.
Current implementation considered runc's case at host. As I said,
containers that don't require executable memfd can migrate their code
and set "vm.memfd_noexec =3D 2", which I hope is easier to do than on
host.

> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
