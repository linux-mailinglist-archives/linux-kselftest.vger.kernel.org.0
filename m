Return-Path: <linux-kselftest+bounces-43123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487ABD8D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5934218A4CB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AB2FBE01;
	Tue, 14 Oct 2025 10:56:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D172FB99A;
	Tue, 14 Oct 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439368; cv=none; b=oj54E46ea/tOR/G/zxiQ8wJFiRtQcH3Z7n9YM+/TwAyxd6UWnyi1nn4frmBuoLU/j8+jwTN/UikwmSIIfGmr9daydJ4WnY2oKW9CN1O6arHTvtIHU8WP+pIy+x18eP0cgAPsDMxrFFfyy8A7h3qGRy0WGpY2fBPc34AqwYyaCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439368; c=relaxed/simple;
	bh=46oU0M6vfaQKa3PYOroPhc0emPkc5386Yytt8tuQfOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXhzxPRh1CU3/zZXiQPIWudWBDdIp0EZH4k1byIEP7ckme9QzmIryvRQb8UPeS6nhbCkaCI7mz9OWxcUhQxR7ZHeygsAslhUqV3ela9qRsXT1LMPmPsym3D9ONMyq2qallVFfew2jJ6UKW43IOqrajbLZjAIQj/Tw7ip79R5aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Petr Mladek <pmladek@suse.com>, Lance Yang <lance.yang@linux.dev>
CC: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, David Hildenbrand <david@redhat.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	"Russell King" <linux@armlinux.org.uk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, "Jonathan Corbet" <corbet@lwn.net>, Joel Granados
	<joel.granados@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Phil
 Auld <pauld@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "Pawan Gupta"
	<pawan.kumar.gupta@linux.intel.com>, Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>, Florian Westphal
	<fw@strlen.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Paul E . McKenney"
	<paulmck@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, "Jason A .
 Donenfeld" <Jason@zx2c4.com>
Subject: RE: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Thread-Topic: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Thread-Index: AQHcPO9h0grxiWd7ak27/owdD96L07TBdJLA
Date: Tue, 14 Oct 2025 10:49:53 +0000
Message-ID: <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
In-Reply-To: <aO4boXFaIb0_Wiif@pathway.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.48
X-FE-Policy-ID: 52:10:53:SYSTEM


> On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> > Thanks for the patch!
> >
> > I noticed the implementation panics only when N tasks are detected
> > within a single scan, because total_hung_task is reset for each
> > check_hung_uninterruptible_tasks() run.
>=20
> Great catch!
>=20
> Does it make sense?
> Is is the intended behavior, please?
>=20

Yes, this is intended behavior

> > So some suggestions to align the documentation with the code's
> > behavior below :)
>=20
> > On 2025/10/12 19:50, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > > immediately upon detecting the first hung task. However, some hung
> > > tasks are transient and the system can recover, while others are
> > > persistent and may accumulate progressively.
>=20
> My understanding is that this patch wanted to do:
>=20
>    + report even temporary stalls
>    + panic only when the stall was much longer and likely persistent
>=20
> Which might make some sense. But the code does something else.
>=20

A single task hanging for an extended period may not be a critical issue, a=
s users might still log into the system to investigate. However, if multipl=
e tasks hang simultaneously-such as in cases of I/O hangs caused by disk fa=
ilures-it could prevent users from logging in and become a serious problem,=
 and a panic is expected.=20


> > > --- a/kernel/hung_task.c
> > > +++ b/kernel/hung_task.c
> > > @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct
> *t, unsigned long timeout)
> > >   	 */
> > >   	sysctl_hung_task_detect_count++;
> > > +	total_hung_task =3D sysctl_hung_task_detect_count -
> > > +prev_detect_count;
> > >   	trace_sched_process_hang(t);
> > > -	if (sysctl_hung_task_panic) {
> > > +	if (sysctl_hung_task_panic &&
> > > +			(total_hung_task >=3D sysctl_hung_task_panic)) {
> > >   		console_verbose();
> > >   		hung_task_show_lock =3D true;
> > >   		hung_task_call_panic =3D true;
>=20
> I would expect that this patch added another counter, similar to
> sysctl_hung_task_detect_count. It would be incremented only once per chec=
k
> when a hung task was detected. And it would be cleared (reset) when no
> hung task was found.
>=20
> Best Regards,
> Petr

