Return-Path: <linux-kselftest+bounces-22531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE29D95BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 11:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF275163D56
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7601C8FD7;
	Tue, 26 Nov 2024 10:42:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF11CCB4B;
	Tue, 26 Nov 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617748; cv=none; b=WJpb5XOFwb8PKTtrvjGz+TjgaZChYBgY2UrUfzc7OtVWTm0VwWLe2V7f05sFRtAwSF0wdnetUkqA4NAEFsIuz9I1Nu910GMfDs+jzV4ImialcPWYsdUut81nrvxrazhre/TprnEl1XqRp8NT+B64PtkwbPIfqVFOCuVcyKaDPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617748; c=relaxed/simple;
	bh=HcXBZKhKro8Mrm0E19xPfTjpRCVC9cZacjQApk3mIXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m12FSE4yYU18QM2PmTUsb62/zqTusnM+ci3yZyvTSmFmXhHvyxCRJSY7emOEoH0wAPjf+ZvYyDBgHWijjMe2C4Q5R7cPtL1Ggh9CDz1hEG8tysqV6WnNpjIA0HYnH0LbJEKAXAxOEzK7TPdw9MFIzpT1BHZhdp+RMq0kGchhEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XyJWh21vLz9v7Vv;
	Tue, 26 Nov 2024 18:21:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5937B140535;
	Tue, 26 Nov 2024 18:42:13 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3IyTspUVnG6xSAg--.24828S2;
	Tue, 26 Nov 2024 11:42:07 +0100 (CET)
Message-ID: <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
Subject: Re: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>, 
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "petr.pavlu@suse.com"
 <petr.pavlu@suse.com>,  "samitolvanen@google.com"
 <samitolvanen@google.com>, "da.gomez@samsung.com" <da.gomez@samsung.com>, 
 Andrew Morton <akpm@linux-foundation.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>,
 "serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>,  "alexandre.torgue@foss.st.com"
 <alexandre.torgue@foss.st.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org"
 <linux-api@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "wufan@linux.microsoft.com"
 <wufan@linux.microsoft.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
  "zbyszek@in.waw.pl" <zbyszek@in.waw.pl>, "hch@lst.de" <hch@lst.de>,
 "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "pmatilai@redhat.com"
 <pmatilai@redhat.com>,  "jannh@google.com" <jannh@google.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,  "jikos@kernel.org"
 <jikos@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "ppavlu@suse.com" <ppavlu@suse.com>, "petr.vorel@gmail.com"
 <petr.vorel@gmail.com>,  "mzerqung@0pointer.de" <mzerqung@0pointer.de>,
 "kgold@linux.ibm.com" <kgold@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 26 Nov 2024 11:41:44 +0100
In-Reply-To: <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3IyTspUVnG6xSAg--.24828S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF15KFWxWFWrtrWxJryUtrb_yoW8JF13pa
	ySga4UKr9Y9r10yF13Aa15ZryFkwsrtr1DZrn8Jry5ArWruryI9348Ca15uFykKr1kJw1a
	qw12ga4xGan8C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGdFMjUC7gAAsf

On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
>=20
> > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawe=
icloud.com> wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > The Integrity Digest Cache can also help IMA for appraisal. IMA can sim=
ply
> > lookup the calculated digest of an accessed file in the list of digests
> > extracted from package headers, after verifying the header signature. I=
t is
> > sufficient to verify only one signature for all files in the package, a=
s
> > opposed to verifying a signature for each file.
>=20
> Is there a way to maintain integrity over time?  Today if a CVE is discov=
ered=20
> in a signed program, the program hash can be added to the blacklist keyri=
ng.=20
> Later if IMA appraisal is used, the signature validation will fail just f=
or that=20
> program.  With the Integrity Digest Cache, is there a way to do this? =
=20

As far as I can see, the ima_check_blacklist() call is before
ima_appraise_measurement(). If it fails, appraisal with the Integrity
Digest Cache will not be done.

In the future, we might use the Integrity Digest Cache for blacklists
too. Since a digest cache is reset on a file/directory change, IMA
would have to revalidate the program digest against a new digest cache.

Thanks

Roberto


