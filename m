Return-Path: <linux-kselftest+bounces-24878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB978A17F9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0963A6247
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D21F3D2A;
	Tue, 21 Jan 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ScTYltdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06D1F03DC;
	Tue, 21 Jan 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469327; cv=none; b=iLc0inMI+0wpNusgqooBqs/SK7NtmK1S8id62S+YxXSfecREpLx61zl1RnuCJoSVq63e48DPdVTSlpbnQiQ0lgJ28GNj+J0nYhZKLBxuJhbtI9kBLBaqluxseeTePid0WLUeF+UPY3poPsjByrXVOWB8DMO6Y3iGrtsj8LPgssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469327; c=relaxed/simple;
	bh=P23ZA3cano5IHMsilVV16S0V+cf/MaFpbbFvpeIdBZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jABQVCVXyZrK48f93IkQnJRn/9zs7hLgrllzw1MjyyjU5U0MpWWg5QskbJyKuFvFDID6xXWgTsnzkb2Skmq2sercssgJTw/1MzNKCK7cjnEj3GB9XmoVcE2BoB3agtu/7kptyUo3Za8hH/dCoUhio0VizhufUzMDMf/F3uFrJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ScTYltdt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737469321;
	bh=P23ZA3cano5IHMsilVV16S0V+cf/MaFpbbFvpeIdBZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScTYltdtaS5AKRs2+tcFhmhz2I16uooDjkyyI2N83M3sktL2qpFK668VwuBrMeXy/
	 du3AVbJNVfHT5ZLlqG/LTa0V48ZttfkRaxnTLRQMGzqhipL2x5AtmWQiQHVbHLocaZ
	 PnynRQI4al9pjZ5eFPan25HQ2A80UUSikQdhw60U=
Date: Tue, 21 Jan 2025 15:21:59 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, corbet@lwn.net, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, akpm@linux-foundation.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com, pbrobinson@gmail.com, 
	zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, 
	jannh@google.com, dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com, 
	ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, kgold@linux.ibm.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 01/15] lib: Add TLV parser
Message-ID: <7b3eaf6d-ca5e-47c9-b26d-8953aece869f@t-8ch.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
 <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
 <fa52e3654a44dd250437ebe3e8397bff95399893.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa52e3654a44dd250437ebe3e8397bff95399893.camel@huaweicloud.com>

On 2025-01-21 14:48:09+0100, Roberto Sassu wrote:
> On Tue, 2025-01-21 at 14:29 +0100, Thomas Weißschuh wrote:
> > Hi Robert,
> > 
> > On 2024-11-19 11:49:08+0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add a parser of a generic Type-Length-Value (TLV) format:
> > > 
> > > +--------------+--+---------+--------+---------+
> > > > field1 (u16) | len1 (u32) | value1 (u8 len1) |
> > > +--------------+------------+------------------+
> > > >     ...      |    ...     |        ...       |
> > > +--------------+------------+------------------+
> > > > fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> > > +--------------+------------+------------------+
> > 
> > Should mention that its big endian.
> 
> Ok.
> 
> > > Each adopter can define its own fields. The TLV parser does not need to be
> > > aware of those, but lets the adopter obtain the data and decide how to
> > 
> > "adopter" -> "user".
> 
> Ok.
> 
> > > continue.
> > > 
> > > After processing a TLV entry, call the callback function also with the
> > > callback data provided by the adopter. The latter can decide how to
> > > interpret the TLV entry depending on the field ID.
> > > 
> > > Nesting TLVs is also possible, the callback function can call tlv_parse()
> > > to parse the inner structure.
> > 
> > Given that we already have the netlink data structures, helpers and
> > infrastructure, what is the advantage over those?
> 
> Sorry, I'm not too familiar on how netlink works, so I might not
> understand your point.

Netlink is a TLV format used by the Linux networking subsystem:

struct nlmsghdr {
    __u32 nlmsg_len;    /* Length of message including header */
    __u16 nlmsg_type;   /* Type of message content */
    __u16 nlmsg_flags;  /* Additional flags */
    __u32 nlmsg_seq;    /* Sequence number */
    __u32 nlmsg_pid;    /* Sender port ID */
};

https://man.archlinux.org/man/core/man-pages/netlink.7.en

There are both userspace and in-kernel infrastructures to handle it.
Looking at it again however it has some unnecessary fields, wasting
space and uses "host" byteorder which is a problem for an on-disk
datastructure.
So maybe not a good alternative after all.

> I think the benefit of this data structure is the retrocompatibility.
> If you add new data fields, you don't need to introduce a v2, v3 data
> format.
> 
> New versions of the parser can consume the new information, while the
> older can still take the ones they are able to understand.

This is also exactly how netlink is used.

FYI there were also some review comments inside the patch diff itself.


Thomas

