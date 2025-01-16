Return-Path: <linux-kselftest+bounces-24666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E6A13FA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DEF188DF96
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5822D4D5;
	Thu, 16 Jan 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN9e+NKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2656C22CA0D;
	Thu, 16 Jan 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045575; cv=none; b=Sm3o1CBYjP1lY0891mN8BoIc8ka2vrP+SmbtvwGd0Auvo/OFxBcV87vqjWa6MMUHfPLmZLISgHKPAWBET/or7yLcna9XE5eCWd4dEUDA+bBL0n2wpeiuXgBuNkoXX1QzXSMxIyzhein3PV+XPh/e223q19OYm1nKO/RFqh5WwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045575; c=relaxed/simple;
	bh=/nZUdW72FcnZOB/BHR1IUXdW0+ZY5TCdthQyv6g7CNE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E/uuOrj+v9tEbe7oxneRfyLgHme6ttq9eGEYvMrxKTeXqxqSbnXXGbUIqqKzMGD07O6i6ExEjWnGLY1gqapFt5IkyhUr2Ez5cz7saLl/8fyYevY1qzAkuSYIUyDeVksljwWdyqZtzeeGbV/2pP7JNxUjRAPuURbdGLOIeli2YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN9e+NKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF37C4CEE2;
	Thu, 16 Jan 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737045574;
	bh=/nZUdW72FcnZOB/BHR1IUXdW0+ZY5TCdthQyv6g7CNE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XN9e+NKjyKXJLkJc+cv+vxeeK7Ycpt/TX+nyqdAAIN5yVOi2QsaxhIV8li4uikr3o
	 +zjD6P6bKVwM8AZgGI+nX1UPBbGV5YQ2Jz7E0aUPyrgQJJjdiT5Xt1xXi9xtLvbGSM
	 HpmPZgg+vix5liWk23TS7kbOMRMCVWrXhl15QJbrM4srCzNCcuZqU3J24NW9c8tOpk
	 Gg01oz+7Zr6TxSv8rzccyoHX706qE67wrizCKrOgdtDJEwSvgMB+flCD+WIbV6dXgo
	 yZqn7leOD8VkjCNvWfkzjiFnfG0Cjg8ym1pHl5Ihw3foW/rANYPMpWM/W4FH32xkGq
	 pY7Pj/oIda0FQ==
Date: Thu, 16 Jan 2025 17:39:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 linux-arm-msm@vger.kernel.org, robh@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
User-Agent: K-9 Mail for Android
In-Reply-To: <20250116161227.gk2psmbzpexswgrm@thinkpad>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org> <Z4knZyKrEvVNopeX@ryzen> <20250116161227.gk2psmbzpexswgrm@thinkpad>
Message-ID: <CCADFA64-D3BD-4972-994A-48E2606CCC66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 January 2025 17:12:27 CET, Manivannan Sadhasivam <manivannan=2Esadha=
sivam@linaro=2Eorg> wrote:
>On Thu, Jan 16, 2025 at 04:36:07PM +0100, Niklas Cassel wrote:
>> On Thu, Jan 16, 2025 at 07:21:02PM +0530, Manivannan Sadhasivam wrote:
>> > Hi,
>> >=20
>> > This series carries forward the effort to add Kselftest for PCI Endpo=
int
>> > Subsystem started by Aman Gupta [1] a while ago=2E I reworked the ini=
tial version
>> > based on another patch that fixes the return values of IOCTLs in
>> > pci_endpoint_test driver and did many cleanups=2E Since the resulting=
 work
>> > modified the initial version substantially, I took over the authorshi=
p=2E
>> >=20
>> > This series also incorporates the review comment by Shuah Khan [2] to=
 move the
>> > existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpo=
int' before
>> > migrating to Kselftest framework=2E I made sure that the tests are ex=
ecutable in
>> > each commit and updated documentation accordingly=2E
>> >=20
>> > - Mani
>> >=20
>> > [1] https://lore=2Ekernel=2Eorg/linux-pci/20221007053934=2E5188-1-ama=
n1=2Egupta@samsung=2Ecom
>> > [2] https://lore=2Ekernel=2Eorg/linux-pci/b2a5db97-dc59-33ab-71cd-f59=
1e0b1b34d@linuxfoundation=2Eorg
>> >=20
>> > Changes in v5:
>> >=20
>> > * Incorporated comments from Niklas
>> > * Added a patch to fix the DMA MEMCPY check in pci-epf-test driver
>> > * Collected tags
>> > * Rebased on top of pci/next 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d
>> >=20
>> > Changes in v4:
>> >=20
>> > * Dropped the BAR fix patches and submitted them separately:
>> >   https://lore=2Ekernel=2Eorg/linux-pci/20241231130224=2E38206-1-mani=
vannan=2Esadhasivam@linaro=2Eorg/
>> > * Rebased on top of pci/next 9e1b45d7a5bc0ad20f6b5267992da422884b916e
>> >=20
>> > Changes in v3:
>> >=20
>> > * Collected tags=2E
>> > * Added a note about failing testcase 10 and command to skip it in
>> >   documentation=2E
>> > * Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addre=
sses are
>> >   bouncing=2E
>> >=20
>> > Changes in v2:
>> >=20
>> > * Added a patch that fixes return values of IOCTL in pci_endpoint_tes=
t driver
>> > * Moved the existing tests to new location before migrating
>> > * Added a fix for BARs on Qcom devices
>> > * Updated documentation and also added fixture variants for memcpy & =
DMA modes
>> >=20
>> >=20
>> > Manivannan Sadhasivam (4):
>> >   PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
>> >   misc: pci_endpoint_test: Fix the return value of IOCTL
>> >   selftests: Move PCI Endpoint tests from tools/pci to Kselftests
>> >   selftests: pci_endpoint: Migrate to Kselftest framework
>> >=20
>> >  Documentation/PCI/endpoint/pci-test-howto=2Erst | 170 +++++------
>> >  MAINTAINERS                                   |   2 +-
>> >  drivers/misc/pci_endpoint_test=2Ec              | 255 +++++++++-----=
---
>> >  drivers/pci/endpoint/functions/pci-epf-test=2Ec |   4 +-
>> >  tools/pci/Build                               |   1 -
>> >  tools/pci/Makefile                            |  58 ----
>> >  tools/pci/pcitest=2Ec                           | 264 --------------=
----
>> >  tools/pci/pcitest=2Esh                          |  73 -----
>> >  tools/testing/selftests/Makefile              |   1 +
>> >  =2E=2E=2E/testing/selftests/pci_endpoint/=2Egitignore |   2 +
>> >  tools/testing/selftests/pci_endpoint/Makefile |   7 +
>> >  tools/testing/selftests/pci_endpoint/config   |   4 +
>> >  =2E=2E=2E/pci_endpoint/pci_endpoint_test=2Ec          | 221 ++++++++=
+++++++
>> >  13 files changed, 435 insertions(+), 627 deletions(-)
>> >  delete mode 100644 tools/pci/Build
>> >  delete mode 100644 tools/pci/Makefile
>> >  delete mode 100644 tools/pci/pcitest=2Ec
>> >  delete mode 100644 tools/pci/pcitest=2Esh
>> >  create mode 100644 tools/testing/selftests/pci_endpoint/=2Egitignore
>> >  create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
>> >  create mode 100644 tools/testing/selftests/pci_endpoint/config
>> >  create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint=
_test=2Ec
>> >=20
>> > --=20
>> > 2=2E25=2E1
>> >=20
>>=20
>> I ran the test using simply:
>>=20
>> $ =2E/pci_endpoint_test
>>=20
>> and got:
>>=20
>> #  RUN           pci_ep_basic=2EMSIX_TEST =2E=2E=2E
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X33
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X34
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X35
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X36
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X37
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X38
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Expected 0 (0) =3D=3D ret (-110)
>> # pci_endpoint_test=2Ec:129:MSIX_TEST:Test failed for MSI-X39
>>=20
>>=20
>> I think that you should also do:
>>=20
>> diff --git a/Documentation/PCI/endpoint/pci-test-howto=2Erst b/Document=
ation/PCI/endpoint/pci-test-howto=2Erst
>> index 7d0dbad61456=2E=2E7d5049c884dd 100644
>> --- a/Documentation/PCI/endpoint/pci-test-howto=2Erst
>> +++ b/Documentation/PCI/endpoint/pci-test-howto=2Erst
>> @@ -81,8 +81,8 @@ device, the following commands can be used::
>> =20
>>         # echo 0x104c > functions/pci_epf_test/func1/vendorid
>>         # echo 0xb500 > functions/pci_epf_test/func1/deviceid
>> -       # echo 16 > functions/pci_epf_test/func1/msi_interrupts
>> -       # echo 8 > functions/pci_epf_test/func1/msix_interrupts
>> +       # echo 32 > functions/pci_epf_test/func1/msi_interrupts
>> +       # echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>> =20
>>=20
>> Such that the documentation suggests values that will actually make the
>> pci_endpoint_test pass without any special parameters set=2E
>>=20
>
>Agree and this is what I am doing locally, but that change is not really =
related
>to this series=2E So I'll submit it separately=2E

I don't not agree that it is not related,
before this series the example output was:


MSI1:           OKAY
-	MSI2:           OKAY
-	MSI3:           OKAY
-	MSI4:           OKAY
-	MSI5:           OKAY
-	MSI6:           OKAY
-	MSI7:           OKAY
-	MSI8:           OKAY
-	MSI9:           OKAY
-	MSI10:          OKAY
-	MSI11:          OKAY
-	MSI12:          OKAY
-	MSI13:          OKAY
-	MSI14:          OKAY
-	MSI15:          OKAY
-	MSI16:          OKAY
-	MSI17:          NOT OKAY
-	MSI18:          NOT OKAY
-	MSI19:          NOT OKAY
-	MSI20:          NOT OKAY
-	MSI21:          NOT OKAY
-	MSI22:          NOT OKAY
-	MSI23:          NOT OKAY
-	MSI24:          NOT OKAY
-	MSI25:          NOT OKAY
-	MSI26:          NOT OKAY
-	MSI27:          NOT OKAY
-	MSI28:          NOT OKAY
-	MSI29:          NOT OKAY
-	MSI30:          NOT OKAY
-	MSI31:          NOT OKAY
-	MSI32:          NOT OKAY
-	SET IRQ TYPE TO MSI-X:          OKAY
-	MSI-X1:         OKAY
-	MSI-X2:         OKAY
-	MSI-X3:         OKAY
-	MSI-X4:         OKAY
-	MSI-X5:         OKAY
-	MSI-X6:         OKAY
-	MSI-X7:         OKAY
-	MSI-X8:         OKAY
-	MSI-X9:         NOT OKAY
-	MSI-X10:        NOT OKAY
-	MSI-X11:        NOT OKAY
-	MSI-X12:        NOT OKAY
-	MSI-X13:        NOT OKAY
-	MSI-X14:        NOT OKAY
-	MSI-X15:        NOT OKAY
-	MSI-X16:        NOT OKAY


So the output matched the suggested values in the documentation=2E

After this series, the documentation still suggests msi =3D=3D 16 and msi-=
x =3D=3D 8,
but the example output now shows that
there was no failures=2E


So I think it is most consistent to just update the example in the same co=
mmit (in this series) that updates the output to show everything as good=2E



Kind regards,
Niklas



>
>>=20
>> Other than that small nit, for the series:
>> Tested-by: Niklas Cassel <cassel@kernel=2Eorg>
>
>Thanks a lot!
>
>- Mani
>
>--=20
>=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

