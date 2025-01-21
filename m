Return-Path: <linux-kselftest+bounces-24881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C4A17FCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18731886E33
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959991F37C1;
	Tue, 21 Jan 2025 14:30:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46451B4237;
	Tue, 21 Jan 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469829; cv=none; b=Yl7J3+QfDQ4EJCem2262dfmHczmMHqWLO+WZhdungnOwqkdKBS3X1YAUKH9V4W0OextwLNO6YdN6ImFCvlKtKE+7fvO8kpdTAb6XujJNO369toeE04ixMw8Gha/BqjEFLi6Q/hlUfRWYmujgXfCZibDuzidQb1L/yC6B5hDyXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469829; c=relaxed/simple;
	bh=8jgPzuwDffY+u5giBXtAHhVi/x5lA7laZ59zgk89YQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVTTKN8fKErNxwu9CrxOUJGMNwSw47CY6PWxZX8UD1mMqfzF1BnCiak0N+uawDn09anJbQBZygluEAGqmZWiXC2WF91J9+lwB1mdsqiJ4k/aR7ovKjtN+AKUYL1BXQE5pSjF2ZeYC8rNxcQCzx9Hw7H/v5fgbraWzHNBetRiZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcpvZ0LvBz9v7W0;
	Tue, 21 Jan 2025 22:08:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3CD4214037F;
	Tue, 21 Jan 2025 22:30:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXG0plr49nIBILAQ--.48896S2;
	Tue, 21 Jan 2025 15:30:21 +0100 (CET)
Message-ID: <b894e43c3bf3c594a87b90ae75141e49fdd577c3.camel@huaweicloud.com>
Subject: Re: [PATCH v6 01/15] lib: Add TLV parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, mcgrof@kernel.org,
 petr.pavlu@suse.com, samitolvanen@google.com,  da.gomez@samsung.com,
 akpm@linux-foundation.org, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 21 Jan 2025 15:29:53 +0100
In-Reply-To: <7b3eaf6d-ca5e-47c9-b26d-8953aece869f@t-8ch.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
	 <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
	 <fa52e3654a44dd250437ebe3e8397bff95399893.camel@huaweicloud.com>
	 <7b3eaf6d-ca5e-47c9-b26d-8953aece869f@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXG0plr49nIBILAQ--.48896S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfZw4fAFyDAFy7XFy3XFb_yoW5XF47pF
	yfJ3W7GFs5Jr1rAr17Kr48JrySqF4rJw1UXF15tryruwn0vr15Gry5GrWF9F9rGrykZr1q
	vayUXasrAr1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGePR1QEQgAAs3

On Tue, 2025-01-21 at 15:21 +0100, Thomas Wei=C3=9Fschuh wrote:
> On 2025-01-21 14:48:09+0100, Roberto Sassu wrote:
> > On Tue, 2025-01-21 at 14:29 +0100, Thomas Wei=C3=9Fschuh wrote:
> > > Hi Robert,
> > >=20
> > > On 2024-11-19 11:49:08+0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Add a parser of a generic Type-Length-Value (TLV) format:
> > > >=20
> > > > +--------------+--+---------+--------+---------+
> > > > > field1 (u16) | len1 (u32) | value1 (u8 len1) |
> > > > +--------------+------------+------------------+
> > > > >     ...      |    ...     |        ...       |
> > > > +--------------+------------+------------------+
> > > > > fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> > > > +--------------+------------+------------------+
> > >=20
> > > Should mention that its big endian.
> >=20
> > Ok.
> >=20
> > > > Each adopter can define its own fields. The TLV parser does not nee=
d to be
> > > > aware of those, but lets the adopter obtain the data and decide how=
 to
> > >=20
> > > "adopter" -> "user".
> >=20
> > Ok.
> >=20
> > > > continue.
> > > >=20
> > > > After processing a TLV entry, call the callback function also with =
the
> > > > callback data provided by the adopter. The latter can decide how to
> > > > interpret the TLV entry depending on the field ID.
> > > >=20
> > > > Nesting TLVs is also possible, the callback function can call tlv_p=
arse()
> > > > to parse the inner structure.
> > >=20
> > > Given that we already have the netlink data structures, helpers and
> > > infrastructure, what is the advantage over those?
> >=20
> > Sorry, I'm not too familiar on how netlink works, so I might not
> > understand your point.
>=20
> Netlink is a TLV format used by the Linux networking subsystem:
>=20
> struct nlmsghdr {
>     __u32 nlmsg_len;    /* Length of message including header */
>     __u16 nlmsg_type;   /* Type of message content */
>     __u16 nlmsg_flags;  /* Additional flags */
>     __u32 nlmsg_seq;    /* Sequence number */
>     __u32 nlmsg_pid;    /* Sender port ID */
> };
>=20
> https://man.archlinux.org/man/core/man-pages/netlink.7.en
>=20
> There are both userspace and in-kernel infrastructures to handle it.
> Looking at it again however it has some unnecessary fields, wasting
> space and uses "host" byteorder which is a problem for an on-disk
> datastructure.
> So maybe not a good alternative after all.
>=20
> > I think the benefit of this data structure is the retrocompatibility.
> > If you add new data fields, you don't need to introduce a v2, v3 data
> > format.
> >=20
> > New versions of the parser can consume the new information, while the
> > older can still take the ones they are able to understand.
>=20
> This is also exactly how netlink is used.

Ok, perfect!

> FYI there were also some review comments inside the patch diff itself.

Ops, thanks! Missed them. Will reply to that email.

Roberto


