Return-Path: <linux-kselftest+bounces-22609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003A9DC084
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 09:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E393D16489C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7303158DD8;
	Fri, 29 Nov 2024 08:31:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9314B088;
	Fri, 29 Nov 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869097; cv=none; b=uGpi5T0WkdJh4fwc0nQV4pUc2f1LQmo9mtxTd0s/v4U0KvkQUreRSLjleBy5kTkdQpjIqXbq5zDW3zDJpYDcH3NN59QJjELuqafaff4XL3ixAzjyjLR/yuUarmMJAQCnAc/vxBKFY5wGbmUny4saIIEOap2kV3b8UssPfckbIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869097; c=relaxed/simple;
	bh=wp3UfZMfbn7EeJtbLpA0FbA0vGdnG3AkBrdTYstEirE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cLOJUfpzWpLBy+VOB//m2WuciYJpOLXRv6A7ZmOjx1SmsvhEkahwpJPLeHARya+07MyHZV4uQqmoqgPi+TVA3FP3xICKx+YO57OWdBb7h3kTXV+5592c5dqBf0xqiTOUj0RoovtgGWH/Cf/OwzH+ZDpMQEdn+uhfyN7jzodSbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y05TF2lVTz9v7Vd;
	Fri, 29 Nov 2024 16:10:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 12FBD1407B1;
	Fri, 29 Nov 2024 16:31:19 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHLn69e0lnwkiCAg--.19693S2;
	Fri, 29 Nov 2024 09:31:15 +0100 (CET)
Message-ID: <57f07e0048ff15fd1ebfb58054e93abdbf8f029c.camel@huaweicloud.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest
 list parsers
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Luis Chamberlain <mcgrof@kernel.org>, mmaurer@google.com, 
	samitolvanen@google.com, KP Singh <kpsingh@kernel.org>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, petr.pavlu@suse.com,
 da.gomez@samsung.com,  akpm@linux-foundation.org, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
 linux-modules@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,  mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, 
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, 
 mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Fri, 29 Nov 2024 09:30:49 +0100
In-Reply-To: <Z0jVQ8Q7AT_9NodI@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
	 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
	 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
	 <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
	 <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>
	 <Z0d4vXuCqjTo_QW1@bombadil.infradead.org>
	 <10c8fd4b53f946c2d7e933a35c6eb36557e8c592.camel@huaweicloud.com>
	 <Z0jVQ8Q7AT_9NodI@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHLn69e0lnwkiCAg--.19693S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5Jr1kKw47uFy3JF17GFg_yoW8CFyrpF
	WFqa4IkFWktr1UCrs29w4UZrW0krsaqry7Gwn8Gr9IvrW3KFy2vryFgF45uFZrKr1xW347
	tw4Fv3sxWws5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBGdJJrUBzwABs1

On Thu, 2024-11-28 at 12:40 -0800, Luis Chamberlain wrote:
> On Thu, Nov 28, 2024 at 09:23:57AM +0100, Roberto Sassu wrote:
> > On Wed, 2024-11-27 at 11:53 -0800, Luis Chamberlain wrote:
> > > On Wed, Nov 27, 2024 at 10:51:11AM +0100, Roberto Sassu wrote:
> > > > For eBPF programs we are also in a need for a better way to
> > > > measure/appraise them.
> > >=20
> > > I am confused now, I was under the impression this "Integrity Digest
> > > Cache" is just a special thing for LSMs, and so I was under the
> > > impression that kernel_read_file() lsm hook already would take care
> > > of eBPF programs.
> >=20
> > Yes, the problem is that eBPF programs are transformed in user space
> > before they are sent to the kernel:
> >=20
> > https://lwn.net/Articles/977394/
>=20
> That issue seems to be orthogonal to your eandeavor though, which just
> supplements LSMS, right?

Yes, correct, the Integrity Digest Cache would be used to search
whatever digest was calculated by LSMs.

Thanks

Roberto

> Anyway, in case this helps:
>=20
> The Rust folks faced some slighty related challenges with our CRC
> validations for symbols, our CRC are slapped on with genksyms but this
> relies on the source code and with Rust the compiler may do final
> touches to data. And so DWARF is being used [1].
>=20
> Although I am not sure of the state of eBPF DWARF support, there is also
> BTF support [0] and most distros are relying on it to make live introspec=
tion=20
> easier, and the output is much smaller. So could DWARF or BTF information
> from eBPF programs be used by the verifier in similar way to verify eBPF
> programs?
>=20
> Note that to support BTF implicates DWARF and the leap of faith for Rust
> modversions support is that most distros will support DWARF, and so BTF
> can become the norm [2].
>=20
> [0] https://www.kernel.org/doc/html/latest/bpf/btf.html
> [1] https://lwn.net/Articles/986892/
> [2] https://lwn.net/Articles/991719/
>=20
>   Luis


