Return-Path: <linux-kselftest+bounces-22301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E59D2CC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DA4B2CDAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2801D95B3;
	Tue, 19 Nov 2024 16:49:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B01D1F50;
	Tue, 19 Nov 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034952; cv=none; b=qEHKR6Xf4fGy6frJzTdyxUJ+AYIcLRMMtBZKYcy1teVzs7GszMindg1eiSmGyKLwwC6scIt96hAD/vsgLxrKUEp/fRSF7BJcivLY2/CPqdkuHPgS0aaOiCYyq/8o3rrgKeZeK51UCWm+R0iXcAxeugyzAGZ7PiXWDKn6W3MrPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034952; c=relaxed/simple;
	bh=Vlo37xqLWz9uZ3CfExdRtRUyK6jGsIhcVtHBVJXH23U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3w6zBWOG1AKWUHLaYMCF2P71+7736iOIbHYZQbLDaVwvkkwmc+SPriq7FunnLhvetksw/rbu52jH3tWZzpScGOHkC7TPGPvN+/Enm30hJ/y/R3EKxhi7pT2eLNLKrQoOZfBtNj6nYJWfPyldSdrrO3W9Gz6+fxllth9ez59CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt8rx4Lmlz9v7JY;
	Wed, 20 Nov 2024 00:21:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 22592140418;
	Wed, 20 Nov 2024 00:49:05 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHsyNtwTxnhjPrAQ--.2023S2;
	Tue, 19 Nov 2024 17:49:04 +0100 (CET)
Message-ID: <6308448307055a821a4d73dbbb373c2cde300cdf.camel@huaweicloud.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest
 list parsers
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Randy Dunlap <rdunlap@infradead.org>, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net, 
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com, 
 da.gomez@samsung.com, akpm@linux-foundation.org, paul@paul-moore.com, 
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 19 Nov 2024 17:48:41 +0100
In-Reply-To: <c6a7b5eb-d2ec-45e5-8a9b-a91f9c0cec78@infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
	 <c6a7b5eb-d2ec-45e5-8a9b-a91f9c0cec78@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHsyNtwTxnhjPrAQ--.2023S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDGF4DJw45AFyrJF4xWFg_yoWxKFbEvr
	yIqrs7GFZ8JFsxCr1akrWSgFZYgry8XF1qyr4jqryDGa4kuwsrCrWfCr1SqF18Jw1xArn5
	CF93Zrn0q34xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUVZ
	2-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IISQAAsS

On Tue, 2024-11-19 at 08:46 -0800, Randy Dunlap wrote:
> Hi--
>=20
> On 11/19/24 2:49 AM, Roberto Sassu wrote:
> > +/**
> > + * struct parser - Structure to store a function pointer to parse dige=
st list
> > + * @list: Linked list
> > + * @owner: Kernel module owning the parser
> > + * @name: Parser name (must match the format in the digest list file n=
ame)
> > + * @func: Function pointer for parsing
> > + *
> > + * This structure stores a function pointer to parse a digest list.
> > + */
> > +struct parser {
> > +	struct list_head list;
> > +	struct module *owner;
> > +	const char name[NAME_MAX + 1];
> > +	parser_func func;
> > +};
>=20
> I would make the struct name not so generic -- maybe digest_parser ...

Hi

sure, thanks for the suggestion!

Roberto


