Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E62323074
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhBWSQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 13:16:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:49423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233907AbhBWSQR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 13:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614104057;
        bh=UWN3l183zAbiXXQl5Z1FP79kj4fY8vt9bxdy1C023fE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RwdP2vo09Qi6yabb1To6m8GrDpYMCrB9Toz8jPhUmaGzm2NF/CJpAr+fO4FkW6UjQ
         sSkQC/QiP6gDhhjy91h8xsZ/5YIedpcHVQhCXMTv/vGRB7XbB0y8uhngFmcvMTo1HY
         q0unAtaYO+aRTwu3lKu6QA3nWsJM5yo8P5wSC6qc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1leuOO2oWf-00iTJH; Tue, 23
 Feb 2021 19:14:17 +0100
Date:   Tue, 23 Feb 2021 19:13:57 +0100
From:   John Wood <john.wood@gmx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <20210223181357.GA3068@ubuntu>
References: <20210221154919.68050-1-john.wood@gmx.com>
 <20210221154919.68050-4-john.wood@gmx.com>
 <085f8f05-243e-fbf0-3f9c-ea011511a296@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085f8f05-243e-fbf0-3f9c-ea011511a296@infradead.org>
X-Provags-ID: V03:K1:ju0O4S8Nvdn1JuYpx180LYXiBWGpIoiYfkvATFebYMFGyfsTHd9
 wRuTsXxl4cu79Pht/Vpfew+2jDvQYKv5iUww/OxpFxO6Oy7oVj13CRoP4wzlOw4xwz8Y5xW
 EV9QLuqoaF7IpDYK0VQf+2Hi29tNzGfTXyrRtfMJ+VHp9d8v+MSrFpBSqlYxp80wKpa8D6C
 PpBaMCipfTcEh6OPnkTJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3q+pBoAH1js=:XR39Nzb2x6fGQ/6FFW3zzi
 Raj2QUKGSNrAnWBTl55EaeZ1FAEaBNFiymAR3DARDcdjHtXDc7MIYW3hdPP2bo/i2u0EES61F
 9NtsbISe79UKtCt+N05uJN1Jj/88oJ3KkWVYsHu7dotTKBpSEYBCVlxcFOLPZh3V8uRpWC+js
 z7UqeD9HfVM+rTCnLJ+N0Du3YMEbVWFnibChC88csO8+qSXSWI8Dza/GbTZAtEeGzU+iPmJ7z
 E+NzoGw87POsGI2iqlOpObfjATGvlXzkYfSiosJym0t89OTroKOd+jqBGQbfWmpT/ml0HEodo
 3m9AC7sPvKRAvk2solGx9x10TF4sa2290yObfJZ2wjoCvMb+ytx3NXZoTerIa3IspleSjeojc
 gYwa9mNScd1Tt8mzItla7bIEaB2U+J+WuOkgjuffDTL5fg7AF85x5AAsfoFMA9nWCKDGJ9RZV
 czw8n7SfEqF6+a3gJ2bIKybk2U2I46Adh3I5JxpyPGh1tQz41e/I89PsTzhBhlD9CdvaTKnnD
 JuKIQUK8MhsAi+8jqBSwJ64rJ4nkTUl0xaQOepAvmRf3pJzPKJ5U1Wc250wLk1VAJIknA6NYx
 RY8f3TMnEU4JsRUqx5jX0RcbhbNM5IcRbk7qIFKxB+0oKgKC94asTvVS6flNDlNPEmpvt2A8Q
 gRAllOR73bp9psFz4pAuW5pp4wUF5Yd6MqUbCS7UgojyzF3moz+H248gDVNY/pLCh9AjhxX04
 9lI5wVTR3Q1JOkrJ3yRm3KmYuZJ4McTThk2Yj2bAquYSFEPDTeos5Ts6yj24IkEgDYA+QOu88
 D2rXeCkbRTJEGMzEa7ACchjgimJVFIYF3CZAhF3WfqLgTyHDyAWZMdh9TILAeQH/73t7+I58G
 oUFu7WyG0wdon7UHw00Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sun, Feb 21, 2021 at 06:25:51PM -0800, Randy Dunlap wrote:
> Hi--
>
> On 2/21/21 7:49 AM, John Wood wrote:
> >
> > +/**
> > + * print_fork_attack_running() - Warn about a fork brute force attack=
.
> > + */
> > +static inline void print_fork_attack_running(void)
> > +{
> > +	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
> > +}
>
> Do these pr_warn() calls need to be rate-limited so that they don't
> flood the kernel log?

I think it is not necessary since when a brute force attack through the fo=
rk
system call is detected, a fork warning appears only once. Then, all the
offending tasks involved in the attack are killed. But if the parent try t=
o run
again the same app already killed, a new crash will trigger a brute force =
attack
through the execve system call, then this parent is killed, and a new warn=
ing
message appears. Now, the parent and childs are killed, the attacks are
mitigated and only a few messages (one or two) have been shown in the kern=
el
log.

Thanks,
John Wood

> > +/**
> > + * print_exec_attack_running() - Warn about an exec brute force attac=
k.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * The statistical data shared by all the fork hierarchy processes ca=
nnot be
> > + * NULL.
> > + *
> > + * Before showing the process name it is mandatory to find a process =
that holds
> > + * a pointer to the exec statistics.
> > + *
> > + * Context: Must be called with tasklist_lock and brute_stats_ptr_loc=
k held.
> > + */
> > +static void print_exec_attack_running(const struct brute_stats *stats=
)
> > +{
> > +	struct task_struct *p;
> > +	struct brute_stats **p_stats;
> > +	bool found =3D false;
> > +
> > +	for_each_process(p) {
> > +		p_stats =3D brute_stats_ptr(p);
> > +		if (*p_stats =3D=3D stats) {
> > +			found =3D true;
> > +			break;
> > +		}
> >  	}
> > +
> > +	if (WARN(!found, "No exec process\n"))
> > +		return;
> > +
> > +	pr_warn("Exec brute force attack detected [%s]\n", p->comm);
> > +}
>
>
> thanks.
> --
> ~Randy
>
