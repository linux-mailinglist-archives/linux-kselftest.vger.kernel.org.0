Return-Path: <linux-kselftest+bounces-23803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1959FF193
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 20:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F718820E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EB1A2C0B;
	Tue, 31 Dec 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sclvEZkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271E189BA2;
	Tue, 31 Dec 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735673639; cv=none; b=GFBSF8otfNC8DmZ1OsEUqMpVXx2+BzSzOWRBP29U7tex30ZItTLncvMrLHjZi7UlEVXf3cRVQc5Sn2Lqz7etX7NGdsV8nhzxJZ3pqzEZ/JikpGdeuUtQHa8R1F7JzrJ8pVs5l8vw/3tkmLS9AALSerhdm7g46HqRHGjdsFDwJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735673639; c=relaxed/simple;
	bh=KqupyILPFMi9uEbau0UcuFjIDkdX7hymInBqWBOZfbU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ipQc0Iteh3QBBPhtJ+6BQSjOYxc28TJbGM2E8pW506Smku0C0ojw/cUhauqZ6+IfUqtuQUXuHOVw4ab236IJ9dJJPzi3Hk/G87zuMqGWOP7X8MbtxNupZtWVFSkmORflRKwaUBvjrjalaQRuOeE5JwXBYXOKxWBlHbhEnwZ3R+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sclvEZkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A10C4CED2;
	Tue, 31 Dec 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735673638;
	bh=KqupyILPFMi9uEbau0UcuFjIDkdX7hymInBqWBOZfbU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sclvEZkJIKc7VrKQuODKYByb5XRo0CmxzeuOlJ9g4s1IJA61jClZ2RtjiPeaNLz8J
	 cJVNfbFragBrtilUEgJKm8RkB8nXT3Kag39p7+hLQbpSWF9eLHNvM2zKKXBrPRlOdy
	 RB+6QNR1BpzoHEeSC1j1GflUFjUG26aQmy+cefWyvCWaRriKWBjrRC4pCBeHYRzN8K
	 M3Gykv1baGWUjSwzCQ86ZSdY6LayLbLd7XwQnzs1sCoFVfhdzeufk2zf1QD/a8XraV
	 Ghi6O3MJ67/xas7YkWrmWvBHeyygz/j4J+9FZCw6RRHjsFxzwpk3OwqnRcNZvHbXLw
	 8S5Yyx04wfy2Q==
Date: Tue, 31 Dec 2024 20:33:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 linux-arm-msm@vger.kernel.org, robh@kernel.org,
 linux-kselftest@vger.kernel.org, Aman Gupta <aman1.gupta@samsung.com>,
 Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/3=5D_selftests=3A_pci=5Fend?=
 =?US-ASCII?Q?point=3A_Migrate_to_Kselftest_framework?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241231191812.ymyss2dh7naz4oda@thinkpad>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org> <20241231131341.39292-4-manivannan.sadhasivam@linaro.org> <Z3QtEihbiKIGogWA@ryzen> <20241231191812.ymyss2dh7naz4oda@thinkpad>
Message-ID: <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 31 December 2024 20:18:12 CET, Manivannan Sadhasivam <manivannan=2Esadh=
asivam@linaro=2Eorg> wrote:
>On Tue, Dec 31, 2024 at 06:42:42PM +0100, Niklas Cassel wrote:
>> On Tue, Dec 31, 2024 at 06:43:41PM +0530, Manivannan Sadhasivam wrote:
>>=20
>> (=2E=2E=2E)
>>=20
>> > +	#  RUN           pci_ep_data_transfer=2Edma=2ECOPY_TEST =2E=2E=2E
>> > +	#            OK  pci_ep_data_transfer=2Edma=2ECOPY_TEST
>> > +	ok 11 pci_ep_data_transfer=2Edma=2ECOPY_TEST
>> > +	# PASSED: 11 / 11 tests passed=2E
>> > +	# Totals: pass:11 fail:0 xfail:0 xpass:0 skip:0 error:0
>> > +
>> > +
>> > +Testcase 11 (pci_ep_data_transfer=2Edma=2ECOPY_TEST) will fail for m=
ost of the DMA
>> > +capable endpoint controllers due to the absence of the MEMCPY over D=
MA=2E For such
>> > +controllers, it is advisable to skip the forementioned testcase usin=
g below
>> > +command::
>>=20
>> Hm=2E=2E this is strictly not correct=2E If will currently fail because=
 pci-epf-test=2Ec
>> does:
>> if ((reg->flags & FLAG_USE_DMA) && epf_test->dma_private)
>> 	return -EINVAL;
>>=20
>> So even if a DMA driver has support for the DMA_MEMCPY cap, if the DMA =
driver
>> also has the DMA_PRIVATE cap, this test will fail because of the code i=
n
>> pci-epf-test=2Ec=2E
>>=20
>
>Right=2E But I think the condition should be changed to test for the MEMC=
PY
>capability instead=2E Like,
>
>diff --git a/drivers/pci/endpoint/functions/pci-epf-test=2Ec b/drivers/pc=
i/endpoint/functions/pci-epf-test=2Ec
>index ef6677f34116=2E=2E0b211d60a85b 100644
>--- a/drivers/pci/endpoint/functions/pci-epf-test=2Ec
>+++ b/drivers/pci/endpoint/functions/pci-epf-test=2Ec
>@@ -328,7 +328,7 @@ static void pci_epf_test_copy(struct pci_epf_test *ep=
f_test,
>        void *copy_buf =3D NULL, *buf;
>=20
>        if (reg->flags & FLAG_USE_DMA) {
>-               if (epf_test->dma_private) {
>+               if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->devic=
e->cap_mask)) {
>                        dev_err(dev, "Cannot transfer data using DMA\n");
>                        ret =3D -EINVAL;
>                        goto set_status;
>

That check does seem to make more sense than the code that is currently th=
ere=2E
(Perhaps send this as a proper patch?)
Note that I'm not an expert at dmaengine=2E

I have some patches that adds DMA_MEMCPY to dw-edma, but I'm not sure if t=
he DWC eDMA hardware supports having both src and dst as PCI addresses, or =
if only one of them can be a PCI address (with the other one being a local =
address)=2E

If only one of them can be a PCI address, then I'm not sure if your sugges=
ted patch is correct=2E


Kind regards,
Niklas

