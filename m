Return-Path: <linux-kselftest+bounces-22273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883769D285F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E782B305B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1911CDFD1;
	Tue, 19 Nov 2024 14:34:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6235E57D;
	Tue, 19 Nov 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026879; cv=none; b=GkfWxbu74wIJscQpr5Oa+WIUrqMFSHkI092TZA/snWxUs6MpT+4N1OzNcMiJ7m0HG9DpchJcLdvgVwt1M9H8z2gX+im+sUcIebtes82d1akSn8PuOqMJXvpbB9zEaYkhgc0jOEPWs8SZtE/L278cuTIwGh9hvythkRXkpkoBgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026879; c=relaxed/simple;
	bh=+Rr/qgOwv8XKND57Q6pl0RBBNPuJNtWXBoNgEYFCPJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyQYwrjHmbJrxUeJTU4tnTxKBgl9gQ5RIPoNuXl34A5D4hWYjdwv580ou27IgLwN1dN2JuYNZh/3yy1BqhGpFHG1XtPcXQdhx9bPyY/ustAy1btsM43tPqKv8j1uuHnhYbY2+ab+Ybqca3OBd9SQoJ4A0oQVCkE2dk0FXlqC7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt5sk0RK3z9v7Jm;
	Tue, 19 Nov 2024 22:07:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 90AC01407FE;
	Tue, 19 Nov 2024 22:34:23 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnGjvQoTxnjr3pAQ--.40220S2;
	Tue, 19 Nov 2024 15:34:22 +0100 (CET)
Message-ID: <58fbc60fccf6d6c9504301adeebf33a46766d507.camel@huaweicloud.com>
Subject: Re: [PATCH v6 02/15] module: Introduce ksys_finit_module()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>
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
 mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 19 Nov 2024 15:33:49 +0100
In-Reply-To: <20241119121402.GA28228@lst.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
	 <20241119121402.GA28228@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnGjvQoTxnjr3pAQ--.40220S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rZr1fXF1UuFWfuw45Jrb_yoWkWFc_uF
	97WryqywsxJw4DZrW7tF1SgFWSgayDJrykZ3yUJFW2q345Gw17KFs5GFyFqF18ta1ktr1k
	WryUXr40vw1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QGbwAAs-

On Tue, 2024-11-19 at 13:14 +0100, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 11:49:09AM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce ksys_finit_module() to let kernel components request a kernel
> > module without requiring running modprobe.
>=20
> That does sound more than sketchy, even more so because the commit log
> completely fails to explain why you'd need to do that.

With my solution, the kernel grants access to a file in user space
depending on whether or not its calculated (or fsverity) digest is
found in an application manifest provided by the software vendor.

However, what it happens is that in the early boot phase the parser is
not loaded yet, and the kernel cannot extract the reference digests
from the application manifest.

Thus, calling request_module() and consequently executing modprobe will
fail, since the kernel does not have its reference digest yet.

Instead, loading the kernel module from the kernel itself works,
because only the kernel module needs to be verified, and that can be
done through its appended signature.

Roberto


