Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABA342E01
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCTPux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:50:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:52525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCTPuw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616255422;
        bh=EtfgOnZg9Z6qjvshAWtu16RZKvn05bQtCzBAK86M/cs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EIu7FMt+pSpqy22curLmVkLJJLYqmPcEPQkYmqMW3mZEqiY3WVjdIta9bmy9oQPhE
         jcLQDiD0Zaul/XVShKlrezCw51Z3+RkFgMCwR5b/1hsLNkNqhKRPIzNHqGTuMwVCW9
         3He2aNjVq/VrgrqoUWfzoMJrYv3uOQb1KQMXs22E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1lYOQf1bEx-00BuUH; Sat, 20
 Mar 2021 16:50:22 +0100
Date:   Sat, 20 Mar 2021 16:50:20 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     John Wood <john.wood@gmx.com>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210320155020.GF3023@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-8-john.wood@gmx.com>
 <202103172108.404F9B6ED2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103172108.404F9B6ED2@keescook>
X-Provags-ID: V03:K1:+cVZqzHxW0HIoxSZUaT6yj0taOzmdRJFFrdSAXoPnjbRl0Vormm
 s+sRmiFaaGGcCBpylGfyi3hYpESL6IP+SwSgMXyyiyXGY9I2WBcW10YctHupP8j3gwui/+Q
 VIkCO2XPRliMIvbWPiKgieSWA0gQ+ID4hNma3o2y6/vU3S1NFSX+5rMIHaKgjedoqBGLFqk
 nleCr9FFdGIJq4sJdqhpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4EvpcNInyw=:vV7LjhpuTinA6uibauVbLa
 A+D2avKYdBISzZIRWHncWLEwlrDKLak2EwQ90ifW89Cfdk5xzyIiezzMVbJ5La5NWPzFw2y5e
 SnV1o+SsX1TmGI7FXHJ6ZqIpCWLRgBNQXAcTYC4ErkwjW9Av4ALd4sm0LzigkoccIjlOJHVSf
 TC7TIaQUPRofKq/WrpUmWr5vMefC4tyrS2Df5ZEQAcS54zUgaNgchgtljJUSgMS9WeKSHuxl5
 8cbaLkGa+jlyhCZDczlOUA1VRNozuXDa89Xk2Ow+VN+V1OCyV8BGYPuSCPH7SuZPgMTsEMN9k
 OLNey2QcAdBGkIqvZ/irMOwN5BGuj5ldLG7YgpdzIx5aBknjCAw6b4CNli3euK5nTq9YtM2bI
 V3i12/wLmFQpNRNMJ90E9akw6jfwx/7zSbH7nddOqRE4h14dprueqtpMFRgBUd9oWj6PMUDaX
 iYK+t3c6kvhwobEjqJ4cao28miCnRmD0KlZbxHQGVX+rDWiWVhFN6/6vdj00bx4KQlQn5IW2A
 tLdJ4FXDdl5C+QkpbKkCLnlid/r2I0QbDzTLkbs6/j9KAyNF5QcK70hM0z5xIvhPmHv4oy9L/
 9qSED51b3YWVtPXVRAac/Lmr1BixtrduuxtsKzIGiKlDFnCE2qVhIAGDamvfjKQ1F9faghpg1
 1V4AuteS8DxOiJI9RigVn2xBDLFoiAl42hPJJTccoZSNZ2fagF8jJlds4P9plzfjT5EdoKLEW
 I9C8d6Ascsg17LNc+fHHanz0wN7heFDch46rIHvF6khSO1KdvOXWEfvBBpAp82tTpdzcIsrMA
 DUrzIpyPuJ+Jxr7Ujh7JGWPTRoSdzk9F2HUo3kpZIkA0M42SYUlVcmh/dqOG8qIdcGs+E9Pa/
 zZVp707VFu3leUnwZmlQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 09:10:05PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:30PM +0100, John Wood wrote:
> > +These statistics are hold by the brute_stats struct.
> > +
> > +struct brute_cred {
> > +	kuid_t uid;
> > +	kgid_t gid;
> > +	kuid_t suid;
> > +	kgid_t sgid;
> > +	kuid_t euid;
> > +	kgid_t egid;
> > +	kuid_t fsuid;
> > +	kgid_t fsgid;
> > +};
> > +
> > +struct brute_stats {
> > +	spinlock_t lock;
> > +	refcount_t refc;
> > +	unsigned char faults;
> > +	u64 jiffies;
> > +	u64 period;
> > +	struct brute_cred saved_cred;
> > +	unsigned char network : 1;
> > +	unsigned char bounds_crossed : 1;
> > +};
>
> Instead of open-coding this, just use the kerndoc references you've
> already built in the .c files:
>
> .. kernel-doc:: security/brute/brute.c
>
Ok, thanks.

John Wood
