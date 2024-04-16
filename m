Return-Path: <linux-kselftest+bounces-8095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B48A6464
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B198D28184B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD16F069;
	Tue, 16 Apr 2024 06:57:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD961118E;
	Tue, 16 Apr 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250624; cv=none; b=sIwHK2KwZy80i9/2Et2UzHCFcCb1rzCFa68CRCHc0sPlkL8IknhA5c6rx+hh1clhqoGgWs1yH30ELvf9RMYMb1XsB2ANJgNrjTYLoVRw3ESMOMFsEvKAtjImgq8ADyCJ4VK3+Fm48dCtikBYrcaZyiMgvdGd6iHVBYTbSvsb7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250624; c=relaxed/simple;
	bh=alaRkY2wBOwgOHdUKdvWn9i7XKY0dz66kU2v7DIz8yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lW+II9/Vb35msyxok/USgQyZxNkt3mncVJA2bDlKn7ytQIJ4XmK9VxWf4mhDFM37jC0BER5YoB0pVwrijDwRfB6qshoi/kN11VG1ZBiYCCy424UBgDt8rcpmjyE6elpbrJ2lmBSP5uuCqQ5PF9+FCUotOEnIWzV8WiIxWnk5ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJZDD23yDz9v7Qy;
	Tue, 16 Apr 2024 14:40:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CB1F61400CC;
	Tue, 16 Apr 2024 14:56:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHsiYkIR5md6RRBg--.14508S2;
	Tue, 16 Apr 2024 07:56:55 +0100 (CET)
Message-ID: <7590bb2153796db28281e81e13173f76ec0be438.camel@huaweicloud.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 akpm@linux-foundation.org, shuah@kernel.org,  mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 16 Apr 2024 08:56:32 +0200
In-Reply-To: <D0KXSLRDNSGJ.2EIFU7NWC20DI@kernel.org>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <D0KXSLRDNSGJ.2EIFU7NWC20DI@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHsiYkIR5md6RRBg--.14508S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW3Kw4DuFWDZFy8JFW3Awb_yoWDWFb_u3
	y09ryqk3sxZr4fCw1j9FyaqrZ2gFWDurW5J34Yqr1Iqrn3JFnxGr4v9F93uw48X3s7twnx
	uryFyr4SywnF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5h5JwAAs+

On Mon, 2024-04-15 at 22:18 +0300, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Integrity detection and protection has long been a desirable feature, t=
o
> > reach a large user base and mitigate the risk of flaws in the software
> > and attacks.
> >=20
> > However, while solutions exist, they struggle to reach the large user
> > base, due to requiring higher than desired constraints on performance,
> > flexibility and configurability, that only security conscious people ar=
e
> > willing to accept.
> >=20
> > This is where the new digest_cache LSM comes into play, it offers
> > additional support for new and existing integrity solutions, to make
> > them faster and easier to deploy.
>=20
> Sorry for nitpicking but what are the existing integrity solutions,=20
> and how does it help with this struggle? I.e. what is the gist here?

No worries... please have a look at patch 14. It should have all the
information.

Thanks

Roberto


