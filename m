Return-Path: <linux-kselftest+bounces-4497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB87850E7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 09:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B721F2174D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253FC8E1;
	Mon, 12 Feb 2024 08:02:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B60F9CA;
	Mon, 12 Feb 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724964; cv=none; b=nFgvfMWBD++EWQR2gIWnSNuskEBykKEyy8iytH1mqYJEpStvOeRp+htgDZBy4TLek4bGYE/RLercAdqEnuglk2i7trIuze6ynMxfhClK6FDN6Ph/8oeRRO0YywkYg6SG9hKmhh+Vwb4YoQFrdv66luFqrWdM6yiS9uJkNbgQPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724964; c=relaxed/simple;
	bh=4NIW/S+1SXSOSu4OX4XJKNnkiHbTJHa6LNjRdW7BjSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/P1/ocQ6em7+eJbsjBPZUeqCQuGBMvD4+MMbKc2/JbsKL6w7Dzg2MJTpQm7dFeQpw5hmOGO9sWH/W//jho5e5lzu6hfDZRjug6WADg+tSpO0drpCoQeW/bvyTAiflAMkNmsynXNiuhHxVJfgzfT4MvBJhaK0IVupY+v4pTz0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TYGl03kj1z9xrsF;
	Mon, 12 Feb 2024 15:47:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6FFAA140118;
	Mon, 12 Feb 2024 16:02:38 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDn3heO0MllesFaAg--.29115S2;
	Mon, 12 Feb 2024 09:02:37 +0100 (CET)
Message-ID: <0d4edea8f075311d3ecedf2471cd6ea3d3a282cf.camel@huaweicloud.com>
Subject: Re: [PATCH v3 02/13] security: Introduce the digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 petrtesarik@huaweicloud.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 12 Feb 2024 09:02:19 +0100
In-Reply-To: <e8378ba2-ccd1-48fe-973d-38986fc0716d@infradead.org>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
	 <20240209140917.846878-3-roberto.sassu@huaweicloud.com>
	 <e8378ba2-ccd1-48fe-973d-38986fc0716d@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDn3heO0MllesFaAg--.29115S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF47WF1fWryftr1rAryUGFg_yoWkAFgEvw
	1xAw1kKFZ8ZFy2yFsFyF48AFWqg3Z7Zr18Gry8tryfZw1fX3sI9FZ7XFnxX3W8W34S9FnI
	kr93Zr9xt3yq9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUU
	UUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj5pEHgAAs-

On Fri, 2024-02-09 at 15:00 -0800, Randy Dunlap wrote:
> Hi--
>=20
> On 2/9/24 06:09, Roberto Sassu wrote:
> > diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kcon=
fig
> > new file mode 100644
> > index 000000000000..0c47d5151f07
> > --- /dev/null
> > +++ b/security/digest_cache/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config SECURITY_DIGEST_CACHE
> > +	bool "Digest_cache LSM"
> > +	default n
> > +	help
> > +	   This option enables an LSM maintaining a cache of digests
> > +	   (e.g. of file content or metadata).
> > +
> > +	   This LSM can support other kernel components in making access
> > +	   control decisions.
> > +
>=20
> nit:  -ESTYLE.
> coding-style.rst says:
>=20
> Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>=20
> > +config DIGEST_LIST_DEFAULT_PATH
> > +	string
> > +	default "/etc/digest_lists"
> > +	help
> > +	   Default directory where digest_cache LSM expects to find digest
> > +	   lists.
>=20
> Same comment for patch 03/13.
> Same comment for patch 04/13.

Hi Randy

thanks, will apply your suggestions to the next version.

Roberto



