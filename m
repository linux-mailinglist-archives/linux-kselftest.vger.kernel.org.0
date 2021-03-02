Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732BE32BCF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Mar 2021 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhCCPFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 10:05:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:54005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577220AbhCBSfW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 13:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614709871;
        bh=049QEMMTFirdrtt3ejL3GvMGWohn27ALsyuc88cRibI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=M0upkUe9HFRxRsuPvuh1svckXRPKr5gL3DQQ4x0QeSj2/q1IgpiHRPadShyzr7qd9
         HonnLjibP2X6GnXnqTs0jyVeklwEDzJdh9f2kbIZC+GG0vhaW1ASu0ScLCWlDYJQio
         JWjROvG2PRHSfIl2adBxsfQYohiVDp6Co++AxWVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1m1JN10l0S-00xd16; Tue, 02
 Mar 2021 19:31:11 +0100
Date:   Tue, 2 Mar 2021 19:31:05 +0100
From:   John Wood <john.wood@gmx.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210302183032.GA3049@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s78dnrm.fsf@linux.intel.com>
X-Provags-ID: V03:K1:WeoEYXh55bWv37mavlKH7fh3XzqmpOD3W36rnrWsiJYbFEhG2Rt
 xO/e7EyM/p037NFF2qC+jUPwV0v1qH5b7qJj9TuSelNaXGgptVmaiu0ZNxgVw+WxRpJJyma
 PtrVzt0uwgV5YR0/wjR3atwl7BC13YDyrYxtIPifshUfFLM4tSzhTn8bXodX6cicsUboxpJ
 zms8mhPhwRmH1D1fz+r9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:awUGrjGviYY=:jfZ9ig1W8P1jOJDgW04KCM
 G/8G7fcO8bCHJ258PhhCXwjRQkH8uR7phO/882J8gQc3+hg2EdwuFFZnsBYdGEBzWETjoKS63
 /YakWXag4+I41S4E6lgMuVsnJ1hvbr4Ga7YoEjnhHiEz1ziZlNp7uh5Yf0rRpCcfQQFpedCGJ
 1PplJmsvUOCrWAPl98XhYjqg2yxn0m9Td94TAkfHQFqmvhYbFHo/2NxdkMwcjC3S2U3P53O7f
 1EGusc+94aFOv6+22hlg4hYQNFzr9Sf/j26rKBbwYeAlMwQdvCgQPS9M7AwcRNvDeDSk8r+yH
 3wRjRWjvdrwcX663jxUvmZxd+5WvmsP7gHseF4FWfAnQb270ZWQo25HgqqinwkTB+RouK9Ho1
 brk/wUfQtvwiUY0avf6MfX87uHylLxyqIskQ8pydwFQx8KO7Y7O/NNg6UC01tnyGmd43sURJb
 SDBZGPNV2nhNCypF8pm3exneSjdnahkdcZnV2EHMpPa218F67nQaXJj2ai15ti8CPyCrBBSVY
 TSxDNWASHLgDJ+FZQRy4HNCnvLt6LPz95qsQO00yYaBlJrfDWg7K7iljcLXvxX/H1RX9Mmd6f
 /+VzJagRZyU0CMZe5K+0Z+0yuDRHxhhtsZYCjxjQF0vHcH5sb7d/8j3m3H6vckOuROjJXpTjS
 YvPqdq6kAm02BJ94G3ZZWSGm3CljFGOFnInWhehJk9Wmo/Ale1/oGWfPaZfqsud/RjKNtsyHL
 NFZzvGkDcwh00H4rMgYTRxAD8XZQQOdEsfdJcCAIT3N3FGCq6tJtf1l1i9U9gUXM/tqsYVtso
 mEZhJBAmZuRTUTu7NyFa1n8+b0u/CzmCI/JB3RVmgSPihSwQ2gBRJiL9OJ6mMnr0G6vih+Kam
 2ZhQEbl2xiouVYWAeUOw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 28, 2021 at 10:56:45AM -0800, Andi Kleen wrote:
> John Wood <john.wood@gmx.com> writes:
> > +
> > +To detect a brute force attack it is necessary that the statistics sh=
ared by all
> > +the fork hierarchy processes be updated in every fatal crash and the =
most
> > +important data to update is the application crash period.
>
> So I haven't really followed the discussion and also not completely read
> the patches (so apologies if that was already explained or is documented
> somewhere else).
>
> But what I'm missing here is some indication how much
> memory these statistics can use up and how are they limited.

The statistics shared by all the fork hierarchy processes are hold by the
"brute_stats" struct.

struct brute_cred {
	kuid_t uid;
	kgid_t gid;
	kuid_t suid;
	kgid_t sgid;
	kuid_t euid;
	kgid_t egid;
	kuid_t fsuid;
	kgid_t fsgid;
};

struct brute_stats {
	spinlock_t lock;
	refcount_t refc;
	unsigned char faults;
	u64 jiffies;
	u64 period;
	struct brute_cred saved_cred;
	unsigned char network : 1;
	unsigned char bounds_crossed : 1;
};

This is a fixed size struct where, in every process crash (due to a fatal
signal), the application crash period (period field) is updated on an on g=
oing
basis using an exponential moving average (this way it is not necessary to=
 save
the old crash period values). The jiffies and faults fields complete the
statistics basic info. The saved_cred field is used to fine tuning the det=
ection
(detect if the privileges have changed) and also is fixed size. And the
remaining flags are also used to narrow the detection (detect if a privile=
ge
boundary has been crossed).

> How much is the worst case extra memory consumption?

In every fork system call the parent statistics are shared with the child
process. In every execve system call a new brute_stats struct is allocated=
. So,
only one brute_stats struct is allocated for every fork hierarchy (hierarc=
hy of
processes from the execve system call). The more processes are running, th=
e more
memory will be used.

> If there is no limit how is DoS prevented?
>
> If there is a limit, there likely needs to be a way to throw out
> information, and so the attack would just shift to forcing the kernel
> to throw out this information before retrying.
>
> e.g. if the data is hold for the parent shell: restart the parent
> shell all the time.
> e.g. if the data is hold for the sshd daemon used to log in:
> Somehow cause sshd to respawn to discard the statistics.

When a process crashes due to a fatal signal delivered by the kernel (with=
 some
user signal exceptions) the statistics shared by this process with all the=
 fork
hierarchy processes are updated. This allow us to detect a brute force att=
ack
through the "fork" system call. If these statistics show a fast crash rate=
 a
mitigation is triggered. Also, these statistics are removed when all the
processes in this hierarchy have finished.

But at the same time these statistics are updated, also are updated the
statistics of the parent fork hierarchy (the statistics shared by the proc=
ess
that "exec" the child process annotated in the last paragraph). This way a=
 brute
force attack through the "execve" system call can be detected. Also, if th=
is
new statistics show a fast crash rate the mitigation is triggered.

> Do I miss something here? How is that mitigated?

As a mitigation method, all the offending tasks involved in the attack are
killed. Or in other words, all the tasks that share the same statistics
(statistics showing a fast crash rate) are killed.

> Instead of discussing all the low level tedious details of the
> statistics it would be better to focus on these "high level"
> problems here.

Thanks for the advise. I will improve the documentation adding these high =
level
details.

> -Andi
>

I hope this info clarify your questions. If not, I will try again.

Thanks,
John Wood
