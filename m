Return-Path: <linux-kselftest+bounces-38297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF77B1B728
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A7317FB8C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DF2798E1;
	Tue,  5 Aug 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqIuO8Zo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142B263F3C;
	Tue,  5 Aug 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406522; cv=none; b=G/Z8bzdQQ/L8kaUb3LIHH6vkq/BHhXPNR/VtJ69yYgjYBqy9r2EUPXQr/WWTv1pXoxcIhtUGU+kSHP1xcU6TRLQCnMUJdyQ4Jq7HSUGeYMqhzKwMaTx0SeT/vLcb2ZTsflW46DH/1ZquElWOWcWsRK6WMFUQrGFy4kRsiI6DtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406522; c=relaxed/simple;
	bh=b7nMlz0hl/YNL4Ew6jtDlQQA/G+wzIxKRhMvw21PRJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdXfqdq2yJ+PPZpnl/Dpg9uiUq1GymhKGSkUVWTbfa6+hrAHwBB+uIvLilxB5w+tp1skajnQM9ZSUgfWv+Q5ZxDt9wZO5R9ejsUJpet5dt7dpo9LkYe4OYGZUn+FLcLioO64VRgjT+dwtWoNqgB7s34x24aEt2WX55gr85afsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqIuO8Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6205CC4CEF7;
	Tue,  5 Aug 2025 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754406522;
	bh=b7nMlz0hl/YNL4Ew6jtDlQQA/G+wzIxKRhMvw21PRJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqIuO8ZobapKuMTYUjgMKIi0YiPul02gRny8USn4lK7qS9VxbuJjE/oT8CJbug2M9
	 qGSxJqMxltHWeH+o9j8fv2pF25ko0zSfbbaD4TeLmtIxsWE6HC9IPYXaRNNY2cTsBk
	 4pd04ZbrVb47vrUZGzDwxAX3mMzOcu0SJqqQAWZsmIeVc/wPxZwXkw7gTyNkkoD6zm
	 A8OOrxT5OPelbHfgXr2fl4z1k6eDwffoehXqwSA845dad4YXUNGrQz0nRE6RP5hpm5
	 8FwBkm1Dd4X3kQGaqJP+OauAqGHfhmOheY4f3qCwGyZ/PQgK6XdVQHERrjonDVCgus
	 sntGHAOAxNl0g==
Date: Tue, 5 Aug 2025 17:08:17 +0200
From: Joel Granados <joel.granados@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Vipin Sharma <vipinsh@google.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <77qzhwwieggkmyguxm6v7dhpro2ez3nch6qelc2dd5lbdgp6hz@dnbfliagwpnv>
References: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rsv7vzz2yb5otiah"
Content-Disposition: inline
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>


--rsv7vzz2yb5otiah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 11:19:58PM +0000, David Matlack wrote:
> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.
Sorry for coming late to the party. Only recently got some cycles to go
through this. This seems very similar to what we are trying to do with
iommutests [3].

>=20
> VFIO selftests aim to enable kernel developers to write and run tests
> that take the form of userspace programs that interact with VFIO and
> IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> new features, regression tests for bugs, and performance tests for
> optimizations.
Have you considered implementing something outside the kernel sources?
Something similar to fstests [1] or blktests [2]?

I ask because I have always seen it as a suit that tests (regression and
performance) the Linux kernel as well as the hardware. By hardware I
mean IOMMU devices, peripherals as well as their QEMU implementations.
Since the scope is quite big, seemed (to me) like a good idea to keep it
out of the kernel sources.

Can you speak to the pros/cons of having it in selftests? (sorry if this
was already answered)

>=20
> These tests are designed to interact with real PCI devices, i.e. they do
> not rely on mocking out or faking any behavior in the kernel. This
> allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> driver, interrupt remapping, IRQ handling, etc.
And depending on how you execute them, you might also be exercising the
QEMU emulation paths. You could even test different HW firmwares if you
wanted to :)

>=20
> For more background on the motivation and design of this series, please
> see the RFC:
>=20
>   https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.co=
m/
>=20
> This series can also be found on GitHub:
>=20
>   https://github.com/dmatlack/linux/tree/vfio/selftests/v1
>=20
=2E..
> Instructions
> -----------------------------------------------------------------------
>=20
> Running VFIO selftests requires at a PCI device bound to vfio-pci for
> the tests to use. The address of this device is passed to the test as
> a segment:bus:device.function string, which must match the path to
> the device in /sys/bus/pci/devices/ (e.g. 0000:00:04.0).
Would you be able to autodetect the devices that are vfio-testable?
I saw this question in the thread, but did not see the answer (sorry
if I missed it).

>=20
> Once you have chosen a device, there is a helper script provided to
> unbind the device from its current driver, bind it to vfio-pci, export
> the environment variable $VFIO_SELFTESTS_BDF, and launch a shell:
If I'm reading the series correctly there is a fair amount of helper
code needed: device (un)binding, checking capabilities, setting up
DMAable memory.... Have you considered a library like libvfn [4] (is
there any other?) to take care of all this?

One of the good things about having all this in a library is that it can
be used in other contexts besides testing.

>=20
>   $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -s
>=20
> The -d option tells the script which device to use and the -s option
> tells the script to launch a shell.
>=20
> Additionally, the VFIO selftest vfio_dma_mapping_test has test cases
> that rely on HugeTLB pages being available, otherwise they are skipped.
> To enable those tests make sure at least 1 2MB and 1 1GB HugeTLB pages
> are available.
>=20
>   $ echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>   $ echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
Should this be automatic? You can just modify nr_hugepages everytime you
execute a test that requires it.

>=20
> To run all VFIO selftests using make:
>=20
>   $ make -C tools/testing/selftests/vfio run_tests
This ties back to having the test suit outside the Linux Kernel sources.
I might not always want/have a Linux Kernel selftests. Like if I would
want to test the Intel/AMD IOMMU implementation in QEMU.

>=20
> To run individual tests:
>=20
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymo=
us_hugetlb_2mb
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mappin=
g_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap
>=20
> The environment variable $VFIO_SELFTESTS_BDF can be overridden for a
> specific test by passing in the BDF on the command line as the last
> positional argument.
>=20
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test 0000:00:04.0
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymo=
us_hugetlb_2mb 0000:00:04.0
>   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mappin=
g_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap 0000:00:04.0
>=20
> When you are done, free the HugeTLB pages and exit the shell started by
> run.sh. Exiting the shell will cause the device to be unbound from
> vfio-pci and bound back to its original driver.
>=20
>   $ echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>   $ echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   $ exit
As before: Can this be done automatically?

>=20
> It's also possible to use run.sh to run just a single test hermetically,
> rather than dropping into a shell:
>=20
>   $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -- tools/testing/=
selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous
>=20
> Tests
> -----------------------------------------------------------------------
>=20
> There are 5 tests in this series, mostly to demonstrate as a
> proof-of-concept:
>=20
>  - tools/testing/selftests/vfio/vfio_pci_device_test.c
>  - tools/testing/selftests/vfio/vfio_pci_driver_test.c
>  - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
>  - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
>  - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
>=20
> Future Areas of Development
> -----------------------------------------------------------------------
>=20
> Library:
>=20
>  - Driver support for devices that can be used on AMD, ARM, and other
>    platforms (e.g. mlx5).
>  - Driver support for a device available in QEMU VMs (e.g.
>    pcie-ats-testdev [1])
>  - Support for tests that use multiple devices.
>  - Support for IOMMU groups with multiple devices.
>  - Support for multiple devices sharing the same container/iommufd.
>  - Sharing TEST_ASSERT() macros and other common code between KVM
>    and VFIO selftests.
Same as before: How about a lib?

>=20
> Tests:
>=20
>  - DMA mapping performance tests for BARs/HugeTLB/etc.
>  - Porting tests from
>    https://github.com/awilliam/tests/commits/for-clg/ to selftests.
>  - Live Update selftests.
>  - Porting Sean's KVM selftest for posted interrupts to use the VFIO
>    selftests library [2]
>=20
=2E..
>=20
> base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
> prerequisite-patch-id: c1decca4653262d3d2451e6fd4422ebff9c0b589
> --=20
> 2.50.0.rc2.701.gf1e915cc24-goog
>=20

Best

[1] https://github.com/kdave/xfstests
[2] https://github.com/linux-blktests/blktests
[3] https://github.com/SamsungDS/iommutests
[4] https://github.com/SamsungDS/libvfn

--=20

Joel Granados

--rsv7vzz2yb5otiah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmiSHlgACgkQupfNUreW
QU9n5QwAlN4q0wm6M2efHhBPz5s8o7xTe59fbZk8Jt0AMTD00DD7LCvTEH7+rlNL
ctB08Z8Z4CAowaiU1UiWq7cRAEZ5GGL2spcQc36XTXtvIk6ApsYP+qVg1ATLjc2S
lr69S4qv/LSpwOmL/vCZTrQgIQMsqnyb1SvmFLm6YiPPJhQB0csPp8VgUmNEcUXU
7De+mBNMb0Z3wjZYCDjRs4SAsyvLnOsjAjlvT5Pe8SMuctmCIZsFHKtSb07p3a3t
0+FTT0mh/JzRzE8KWCZN3Q15/0juhkfXJP3fdTk1iWfV9IBlaFCihOUcsLovO/iw
uRvG8kAWkzp0+TyZJiGk2QkXaDxQjGeW0gsC1Nxk0Gcaq/dciUSMCD2zXLEMSVqG
ClWuI8nhPYonHWAOJAWb1SF2KFEoWIc+NUKqtPlzgCzmU+j7KcC+FRCnEjt533zs
nmhosqrKfGW4W56A4dVed7dBACKvLTSEUYVtfIBIvvv9rcT2xXtDWI8PaAzk9d3k
rnI0THXx
=ZDn9
-----END PGP SIGNATURE-----

--rsv7vzz2yb5otiah--

