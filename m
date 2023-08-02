Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8276DB47
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjHBXMn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHBXMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 19:12:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FC19A4
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 16:12:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso124301cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691017955; x=1691622755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RSc2mv52VJAw0IWJVMgPvl170FHZjlXhjTzAhGmjS8=;
        b=TxnUEgwM/Aq99m5DWV/8HhG1NHZt/kCAIFL0bKffotQ6QI9eGPgvoQnlM9bpI3qX56
         BHt9zKEEM/Mn59Sgc6kf09fKcYGIRNELRpQP7zHfoxqa6XMYnHAVgTRB6/8pC27RZQzB
         3GvNhRArFHBh6yBSjFYDZob88QNW6a7cZTjZi3YbUWFqgTW7+zHDmTvMUVvhI0MIUm7e
         EYsGMgeoS9eJc2l3SRPpVvt/L8u8GjPUppsjx+C0BXVuvHRMW9rcuYhkNzoJi7Zb9Oh5
         Am4alu9VUUQRuA+zESCkma02lzf5Qi2E78hgyvbypltbXiFTw9Wo3ltujyxR30FghEjs
         w1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017955; x=1691622755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RSc2mv52VJAw0IWJVMgPvl170FHZjlXhjTzAhGmjS8=;
        b=JelQWx+an8UwDjAQDGebQ7OZeiDMFQMhFoKkDONHGCRvXkpMQS2r10mphILW1MHseR
         R2fSr+4hprH9Rj+60h80si6ryQyDG8sDwc47AS48N4l9UsZ27ngLroxPJtHAj96gjeeZ
         OXDQRspHgBXh+Ep3muGoFe21H39xjtffJGvaB912HmMljefVbT/mA1pAI0rzuN9AKFMc
         NueLDZRWX13j/IHPQ8UlIIwbufC/eXADdJ5duBV+EreOvoBOE2xoSJ+lsQGgBK7Ji8nL
         Si2b/b/YRNoH1fvycPYR373Bg/mDhxswXMMzttPZ0TdcHyPNWVw7BwSyxLIun8AkH/Za
         7THQ==
X-Gm-Message-State: ABy/qLZfwC0bDyhjWTBVRXPBrZzMxVveKnNbwnSfnxdewvhSyBoYWPGm
        UyaSQcYYO9SbfIXeAr79gwU3sS8sV0+6Dk3WFCLkZQaopAxLzplcp2c/Zw==
X-Google-Smtp-Source: APBJJlE+QhHFJEBtiL0WPJlY+j+UBoOoAIoJn6AFQ8PeAUlwaZyEmJnC5Mwlj9SQvLZjeXlaBsol3Dv3OWqnXOf5rEI=
X-Received: by 2002:a05:622a:28e:b0:405:432b:9973 with SMTP id
 z14-20020a05622a028e00b00405432b9973mr1176243qtw.0.1691017954844; Wed, 02 Aug
 2023 16:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
 <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
 <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com> <20230802.211829-obedient.verb.pointed.walk-inxghgNcxn@cyphar.com>
In-Reply-To: <20230802.211829-obedient.verb.pointed.walk-inxghgNcxn@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 2 Aug 2023 16:11:57 -0700
Message-ID: <CALmYWFuahdUF7cT4cm7_TGLqPanuHXJ-hVSfZt7vpTnc18DPrw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 2, 2023 at 2:39=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2023-08-02, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Tue, Aug 1, 2023 at 6:05=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> > >
> > This thread is getting longer with different topics, I will try to
> > respond with trimmed interleaved replies [1]
> > There are 3 topics (logging/'migration/ratcheting), this response will
> > be regarding ratcheting.
>
> The migration and ratcheting topics are interconnected because the
> migration issue makes ratcheting an even more severe issue. But I'll
> respond to each thread separately.
>
> > [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.h=
tml?highlight=3Dsigned%20off#use-trimmed-interleaved-replies-in-email-discu=
ssions
> >
> > >
> > > > > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make =
sense as a
> > > > > > >    security mechanism because a CAP_SYS_ADMIN capable user ca=
n create
> > > > > > >    executable binaries in a hidden tmpfs very easily, not to =
mention the
> > > > > > >    many other things they can do.
> > > > > > >
> > > > > > By further limiting CAP_SYS_ADMIN, an attacker can't modify thi=
s
> > > > > > sysctl even after compromising some system service with high
> > > > > > privilege, YAMA has the same approach for ptrace_scope=3D3
> > > > >
> > > > > Personally, I also think this behaviour from YAMA is a little goo=
fy too,
> > > > > but given that it only locks the most extreme setting and there i=
s no
> > > > > way to get around the most extreme setting, I guess it makes some=
 sense
> > > > > (not to mention it's an LSM and so there is an argument that it s=
hould
> > > > > be possible to lock out privileged users from modifying it).
> > > > > There are many other security sysctls, and very few have this beh=
aviour
> > > > > because it doesn't make much sense in most cases.
> > > > >
> > > > > > In addition, this sysctl is pid_name spaced, this means child
> > > > > > pid_namespace will alway have the same or stricter security set=
ting
> > > > > > than its parent, this allows admin to maintain a tree like view=
. If we
> > > > > > allow the child pid namespace to elevate its setting, then the
> > > > > > system-wide setting is no longer meaningful.
> > > > >
> > > > > "no longer meaningful" is too strong of a statement imho. It is s=
till
> > > > > useful for constraining non-root processes and presumably ChromeO=
S
> > > > > disallows random processes to do CLONE_NEWUSER (otherwise the pro=
tection
> > > > > of this sysctl is pointless) so in practice for ChromeOS there is=
 no
> > > > > change in the attack surface.
> > > > >
> > > > > (FWIW, I think tying this to the user namespace would've made mor=
e sense
> > > > > since this is about privilege restrictions, but that ship has sai=
led.)
> > > > >
> > > > The reason that this sysctl is a PID namespace is that I hope a
> > > > container and host can have different sysctl values, e.g. host will
> > > > allow runc's use of X mfd, while a container  doesn't want X mfd. .
> > > > To clarify what you meant, do you mean this: when a container is in
> > > > its own pid_namespace, and has "=3D2", the programs inside the cont=
ainer
> > > > can still use CLONE_NEWUSER to break out "=3D2" ?
> > >
> > > With the current implementation, this is not possible. My point was t=
hat
> > > even if it were possible to lower the sysctl, ChromeOS presumably
> > > already blocks the operations that a user would be able to use to cre=
ate
> > > a memfd (an unprivileged user cannot CLONE_NEWPID to modify the sysct=
l
> > > without CLONE_NEWUSER, which is presumably blocked on ChromeOS due to
> > > the other security concerns).
> > >
> > >
> > > > > > The code sample shared in this patch set indicates that the att=
acker
> > > > > > already has the ability of creating tmpfs and executing complex=
 steps,
> > > > > > at that point, it doesn't matter if the code execution is from =
memfd
> > > > > > or not. For a safe by default system such as ChromeOS, attacker=
s won't
> > > > > > easily run arbitrary code, memfd is one of the open doors for t=
hat, so
> > > > > > we are disabling executable memfd in ChromeOS. In other words: =
 if an
> > > > > > attacker can already execute the arbitrary code as sample given=
 in
> > > > > > ChromeOS, without using executable memfd,  then memfd is no lon=
ger the
> > > > > > thing we need to worry about, the arbitrary code execution is a=
lready
> > > > > > achieved by the attacker. Even though I use ChromeOS as an exam=
ple, I
> > > > > > think the same type of threat model applies to any system that =
wants
> > > > > > to disable executable memfd entirely.
> > > > >
> > > > > I understand the threat model this sysctl is blocking, my point i=
s that
> > > > > blocking CAP_SYS_ADMIN from modifying the setting doesn't make se=
nse
> > > > > from that threat model. An attacker that manages to trick some pr=
ocess
> > > > > into creating a memfd with an executable payload is not going to =
be able
> > > > > to change the sysctl setting (unless there's a confused deputy wi=
th
> > > > > CAP_SYS_ADMIN, in which case you have much bigger issues).
> > > > >
> > > > It is the reverse.  An attacker that manages to trick some
> > > > CAP_SYSADMIN processes into changing this sysctl value (i.e. lower =
the
> > > > setting to 0 if no ratcheting), will be able to continue to use mfd=
 as
> > > > part of the attack chain.
> > > >  In chromeOS, an attacker that can change sysctl might not necessar=
ily
> > > > gain full arbitrary code execution already. As I mentioned previous=
ly,
> > > > the main threat model here is to prevent  arbitrary code execution
> > > > through mfd.  If an attacker already gains arbitrary code execution=
,
> > > > at that point, we no longer worry about mfd.
> > >
> > > If an attacker can trick a privileged process into writing to arbitra=
ry
> > > sysctls, the system has much bigger issues than arbitrary (presumably
> > > unprivileged) code execution. On the other hand, requiring you to reb=
oot
> > > a server due to a misconfigured sysctl *is* broken.
> > >
> > > Again, at the very least, not even allowing capable(CAP_SYS_ADMIN) to
> > > change the setting is actually broken.
> > >
> > > > > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, block=
ing it
> > > > > doesn't add any security because that process could create a memf=
d-like
> > > > > fd to execute without issues.
> > > > >What practical attack does this ratcheting
> > > > > mechanism protect against? (This is a question you can answer wit=
h the
> > > > > YAMA sysctl, but not this one AFAICS.)
> > > > >
> > > > > But even if you feel that allowing this in child user namespaces =
is
> > > > > unsafe or undesirable, it's absolutely necessary that
> > > > > capable(CAP_SYS_ADMIN) should be able to un-brick the running sys=
tem by
> > > > > changing the sysctl. The alternative is that you need to reboot y=
our
> > > > > server in order to un-set a sysctl that broke some application yo=
u run.
> > > > >
> > > >
> > > > > Also, by the same token, this ratcheting mechanism doesn't make s=
ense
> > > > > with =3D1 *at all* because it could break programs in a way that =
would
> > > > > require a reboot but it's not a "security setting" (and the YAMA =
sysctl
> > > > > mentioned only locks the sysctl at the highest setting).
> > > > >
> > > > I think a system should use "=3D0" when it is unsure about its prog=
ram's
> > > > need or not need executable memfd. Technically, it is not that this
> > > > sysctl breaks the user, but the admin  made the mistake to set the
> > > > wrong sysctl value, and an admin should know what they are doing fo=
r a
> > > > sysctl. Yes. rebooting increases the steps to undo the mistake, but
> > > > that could be an incentive for the admin to fully test its programs
> > > > before turning on this sysctl - and avoid unexpected runtime errors=
.
> > >
> > > I don't think this stance is really acceptable -- if an admin that ha=
s
> > > privileges to load kernel modules is not able to disable a sysctl tha=
t
> > > can break working programs without rebooting there is
> > >
> > > When this sysctl was first proposed a few years ago (when kernel folk=
s
> > > found out that runc was using executable memfds), my understanding is
> > > that the long-term goal was to switch programs to have
> > > non-executable-memfds by default on most distributions. Making it
> > > impossible for an admin to lower the sysctl value flies in the face o=
f
> > > this goal.
> > >
> > > At the very least, being unable to lower the sysctl from =3D1 to =3D0=
 is
> > > just broken (even if you use the yama example -- yama only locks the
> > > sysctl at highest possible setting, not on lower settings). But in my
> > > view, having this sysctl ratchet at all doesn't make sense.
> > >
> > To reiterate/summarize the current mechanism for vm.memfd_noexec
> >
> > 1> It is a pid namespace sysctl,  init ns and child pid ns can have
> > different setting values.
> > 2> child pid ns inherits parent's pid ns's sysctl at the time of fork.
> > 3> There are  3 values for the sysctl, each higher value is more
> > restrictive than the lower one. Once set, doesn't allow downgrading.
> >
> > It can be used as  following:
> > 1>
> > init ns: vm.memfd_noexec =3D 2 (at boot time)
> > Not allow executable memfd for the entire system, including its contain=
ers.
> >
> > 2>
> > init ns: vm.memfd_noexec =3D 0 or 1
> > container (child init namespace) vm.memfd_noexec =3D 2.
> > The host allows runc's usage of executable memfd during container
> > creation. Inside the container, executable memfd is not allowed.
> >
> > The inherence + not allow downgrading is to reason with how
> > vm.memfd_noexec is applied in the process tree.
> > Without it, essentially we are losing the hierarchy view across the
> > process tree and  a process can evaluate its capability by modifying
> > the setting. I think that is a less secure approach I would not
> > prefer.
>
> If you really want the hierarchical aspect, we can implement it so that
> it's _actually_ hierarchical like so:
>
>  * By default, your setting is the same as your parent (this is checked
>    by going up the pidns tree -- a-la cgroups). This is less efficient
>    but you want a hierarchy, so we can do it this way instead.
>  * If you set a specific setting, that takes precedence but only if it's
>    a greater or equal setting to your parent.
>  * Trying to set a lower setting than your parent fails regardless of
>    privileges.
>
> This will allow *privileged users* to lower the setting, but only if
> the parent pidns also has a lower setting. This allows a system admin to
> enforce the setting. It seems to me that this fulfils all the
> requirements you have.
>
> Most importantly, this would allow for a hierarchical view without
> having a sysctl that will break systems and nobody will use. I need to
> re-iterate this point -- nobody is going to use this sysctl as it
> currently works because it ratchets in a way that admins cannot undo. In
> practice this would mean you would need to reboot your whole datacenter
> if you didn't catch that an update to one of you dependencies didn't
> pass a required *noop* flag to memfd_create().
>
Yes. I agree this is another way to implement a hierarchical view,
which is a little more costly,  because it goes up the process tree.
I respectfully disagree that nobody will use the current sysctl
though, I can still see that a container might want this,  e.g. a
small container that doesn't require a lot of refactoring to add NX,
and restarting container usually isn't a problem, and container might
like the fact that downgrade is denied at run time.

Thanks
Best regards,
-Jeff
