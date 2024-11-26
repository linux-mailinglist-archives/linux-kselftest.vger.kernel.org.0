Return-Path: <linux-kselftest+bounces-22523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A29D92CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 08:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC71285A9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D3199223;
	Tue, 26 Nov 2024 07:56:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790A17C208;
	Tue, 26 Nov 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607802; cv=none; b=V6zouQ5YBN5+HLhrcB2IgNDfcAF46zC0NBdVf3ooL6OQ0Yy5a8rQHDnC/wW4pU8m4JZhcMFozd4akE2o9oUVL0c+UGxEnYkJyE9hq6pP8N4GN850BcTgPLe9RiCTdBOwpkyvjhQmm1wrtqlKqtifLGif5Y8oS9DGau3ucYDRXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607802; c=relaxed/simple;
	bh=s43ZtC0cw/RGoVojffgur6NuC7rhSPw/KecGEuXixqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IzBPIEQBcAWzIiNqcpCACAOjMAnk6ktWEZfloU5BjkcBxvKTusnVQXIPza7L5C19Fgpo9YFicA6BZfEoSdosJTUFyIHuarLtDFyiH4hOmgzrn6DvOiE7/lyTLxvXx3PRJdsruE7IpNJhPoNE9dunHkYXYY7nFTWjd7fKDMlOwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XyDrS1FFQz9v7Nd;
	Tue, 26 Nov 2024 15:35:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 31E0514022D;
	Tue, 26 Nov 2024 15:56:36 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBHADEef0VnFOBQAg--.55978S2;
	Tue, 26 Nov 2024 08:56:35 +0100 (CET)
Message-ID: <7b83391cfa1150f96ff81f727c3bd2a1dbf902bb.camel@huaweicloud.com>
Subject: Re: [PATCH v6 02/15] module: Introduce ksys_finit_module()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net, 
 petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
 akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
 serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl, 
 mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 26 Nov 2024 08:56:11 +0100
In-Reply-To: <Z0UK4Zm85GzeLt20@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
	 <20241119121402.GA28228@lst.de> <ZzzwxdHbG9HynADT@bombadil.infradead.org>
	 <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>
	 <Z0UK4Zm85GzeLt20@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBHADEef0VnFOBQAg--.55978S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26rWY6Fy7MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGdFMnMBFAACsh

On Mon, 2024-11-25 at 15:40 -0800, Luis Chamberlain wrote:
> On Wed, Nov 20, 2024 at 10:16:23AM +0100, Roberto Sassu wrote:
> > Again, maybe I misunderstood, but I'm not introducing any functional
> > change to the current behavior, the kernel side also provides a file
> > descriptor and module arguments as user space would do (e.g. by
> > executing insmod).
>=20
> The commit log does an extremely poor job to make this clear, all you
> are doing here is adding a helper. The commit log should be super clear
> on that and it is not.

Correct, yes. Will do a much better and clear commit message for next
version.

Thanks

Roberto


