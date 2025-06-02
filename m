Return-Path: <linux-kselftest+bounces-34184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F96ACBD9F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA073A3F5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B4200112;
	Mon,  2 Jun 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2HBt0ZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892021F4163
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905690; cv=none; b=l3cejg247cv9p6o4AUr61pYzA9jzgd5fGTqCivkW9pPIpKslHXil7Jo+Kcs3O9bwjppBUyHeJru6mj2LHHSR1bysJVnbrhaXME9ejTZ10WjZcMS8SwoRQKDDtZ2W8svS1UqytK66ibLQDAu9y9iPaGVHr7ZDPVFNbJO4MCHG1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905690; c=relaxed/simple;
	bh=4M/M5WQqG5s1lrRiEYVr2bXVi+IMy8tfhsRTCu06Qyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCWYzN5foESnvZXwoIHhqR5HcmmW0fzvK9zXIW78W/sAOTAwzCo2lG5c5RS32L6mIeEZtdslILUo2pHJSEUpj645Slt2OPVFpasaeBZ1rEetD6QctbbcczNybn8W8ud2vtfK8ORGAMXk64EuTIsecE9Up1rKKRSexLGisZf0W+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2HBt0ZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748905687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/EsVOWnpMJ6iYDXJnG9LHLh+Zoc/oiL7FCABJxLDFM=;
	b=B2HBt0ZSy2FEFh7elef2KodN3Kc29PrHuoXW454yTSiCw4KryKo7Ob/rDTGViMm2h/cFKt
	Wdx3X/Asw8DQlvnfJTKe+LsGgQEVLp5t3XrxlDOPUq0LT8kGnJ5FyIqHyQmgQC3QAR+QLn
	ldcplb0IzL1LsRRHF+/iDjQ6A0PANuE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-cAaWmnenM5Wc_qYGTjBMcg-1; Mon, 02 Jun 2025 19:08:06 -0400
X-MC-Unique: cAaWmnenM5Wc_qYGTjBMcg-1
X-Mimecast-MFC-AGG-ID: cAaWmnenM5Wc_qYGTjBMcg_1748905685
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3dd756e44bcso6193295ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 16:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905685; x=1749510485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/EsVOWnpMJ6iYDXJnG9LHLh+Zoc/oiL7FCABJxLDFM=;
        b=MoJocQ5Gay2pJ3x4wysM0AtpaD7Y+7tWTjNbk2N0S8O0hneE7EfbD/b0SkDoShj0S8
         oIGa0FqCH9YD4S9biS/wGYl7cci7FhgQ6bQiR6qUEd0KpzgnV7gitn3zJ2e6jlIYEL8S
         sgNrRlI64U/ISLIGAqAKBnjolzGcp/0KqcTyyUnCNKwaEf914hN2xRzIq5bH0upzuiq/
         5xC00Tf1bD3G5uSgfmnIMSCyhke5a/vsUff3mS/qr3ONCf6O1Ivvz+XHESFRNW2m6MQL
         jd1zMx1DguR0daJMHZs0V4rCgKMS+lKsCHv0AGOu9bRtrcyelGOrKneItZZrcbL9JHar
         ie4A==
X-Forwarded-Encrypted: i=1; AJvYcCXjkaMCuugaSF/ApoRBxXyiIdtf89SGLro97TIU5ehJkQd1n7cYgW/OTJqYiIImCrBdhesUEhizRyX4JsoFTUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGH3RFrxzaYGTjeKhP/hBZSnGfeBn/1Z8uLDjyTAtPY/U7/nF+
	SHvMK9P18WU2JjfpIyCXYFcMj8pBy+fqctwbydXZFsPzU/qPJUIYVVjCY0OhpBuG4ob/YIX6Aii
	Cr1dbTf6Nf334IRVLxSrnO9aZTdf0pp6WBlBGa4Z5vXejvHWQsSKrY3UQUxHfQ0uQanr83g==
X-Gm-Gg: ASbGncucLPXT61GGVmJDhLsoMT3sfjWTVKmfs7xA3XZuiS71spvw26ckO0Uk/xvoA0l
	eQoKFtrBQQEUmviHpjusxnrmeJu3UNB7uhewBndob9b3vwcCtX/q6gFd2TmfP0u6K2Z42dPlRvF
	5BSAGFi9zKU4QCIRjcjSJgNxfevKdjZjAGKT05p9Jy5QwQOZHGJglawC7n8DF6ZlAgMIPgBagQ9
	n8t6YFGka33MBEynTlLvXmcbMQuh8H6hrbGeNbBeVyxicGl+KKk57QxAFcDUrawvUSpJNTeZO2O
	z6oyxpVkauKxgK0=
X-Received: by 2002:a05:6e02:198d:b0:3dd:990b:83e3 with SMTP id e9e14a558f8ab-3dd9b9daa07mr45691625ab.0.1748905685457;
        Mon, 02 Jun 2025 16:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG14zzzU64KAl3giOhOLlTEbtKncAHiKq2onatleAUwdaqT/+RfXpXY1f6avnBFReEvfEkfJQ==
X-Received: by 2002:a05:6e02:198d:b0:3dd:990b:83e3 with SMTP id e9e14a558f8ab-3dd9b9daa07mr45691305ab.0.1748905685037;
        Mon, 02 Jun 2025 16:08:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd93535841sm23749985ab.4.2025.06.02.16.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:08:03 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:07:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, Sean
 Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger
 <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, Jason Gunthorpe
 <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma
 <vipinsh@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 30/33] vfio: selftests: Add a script to help with
 running VFIO selftests
Message-ID: <20250602170759.6031b4f4.alex.williamson@redhat.com>
In-Reply-To: <20250523233018.1702151-31-dmatlack@google.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
	<20250523233018.1702151-31-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 23:30:15 +0000
David Matlack <dmatlack@google.com> wrote:

> Introduce run.sh, a script to help with running VFIO selftests. The
> script is intended to be used for both humans manually running VFIO
> selftests, and to incorporate into test automation where VFIO selftests
> may run alongside other tests. As such the script aims to be hermetic,
> returning the system to the state it was before the test started.
> 
> The script takes as input the BDF of a device to use and a command to
> run (typically the command would be a VFIO selftest). e.g.
> 
>   $ ./run.sh -d 0000:6a:01.0 ./vfio_pci_device_test
> 
>  or
> 
>   $ ./run.sh -d 0000:6a:01.0 -- ./vfio_pci_device_test
> 
> The script then handles unbinding device 0000:6a:01.0 from its current
> driver, binding it to vfio-pci, running the test, unbinding from
> vfio-pci, and binding back to the original driver.
> 
> When run.sh runs the provided test, it does so by appending the BDF as
> the last parameter. For example:
> 
>   $ ./run.sh -d 0000:6a:01.0 -- echo hello
> 
> Results in the following being printed to stdout:
> 
>   hello 0000:6a:01.0
> 
> The script also supports a mode where it can break out into a shell so
> that multiple tests can be run manually.
> 
>   $ ./run.sh -d 0000:6a:01.0 -s
>   ... bind to vfio-pci and launch $SHELL ...
>   $ echo $BDF
>   0000:6a:01.0
>   $ ./vfio_pci_device_test $BDF
>   ...
>   $ exit
>   ... unbind from vfio-pci ...
>   $
> 
> Choosing which device to use is up to the user.
> 
> In the future this script should be extensible to tests that want to use
> multiple devices. The script can support accepting -d BDF multiple times
> and parse them into an array, setup all the devices, pass the list of
> BDFs to the test, and then cleanup all the devices.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/vfio/Makefile |   1 +
>  tools/testing/selftests/vfio/run.sh   | 110 ++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100755 tools/testing/selftests/vfio/run.sh
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 21fb1809035e..2ab86bd930b0 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -3,6 +3,7 @@ TEST_GEN_PROGS_EXTENDED += vfio_dma_mapping_test
>  TEST_GEN_PROGS_EXTENDED += vfio_iommufd_setup_test
>  TEST_GEN_PROGS_EXTENDED += vfio_pci_device_test
>  TEST_GEN_PROGS_EXTENDED += vfio_pci_driver_test
> +TEST_PROGS_EXTENDED := run.sh
>  include ../lib.mk
>  include lib/libvfio.mk
>  
> diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/run.sh
> new file mode 100755
> index 000000000000..b461cc1b2f11
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/run.sh
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +readonly VFIO_PCI_DRIVER=/sys/bus/pci/drivers/vfio-pci
> +
> +function bind() {
> +	echo "Binding ${1} to ${2}"
> +	echo "${1}" > "${2}/bind"
> +}
> +
> +function unbind() {
> +	echo "Unbinding ${1} from ${2}"
> +	echo "${1}" > "${2}/unbind"
> +}
> +
> +function set_sriov_numvfs() {
> +	echo "Setting ${1} sriov_numvfs to ${2}"
> +	echo ${2} > /sys/bus/pci/devices/${1}/sriov_numvfs
> +}
> +
> +function add_id() {
> +	if echo $(echo ${1} | tr : ' ') > ${2}/new_id 2> /dev/null; then
> +		echo "Added ${1} to ${2}"
> +		return 0
> +	fi
> +
> +	return 1
> +}

I'd suggest using the newer driver_override mechanism rather than
new_id/remove_id.

I appreciate the work here, I think this could be really useful.  As
Jason notes a few times, I'd also like to see this automatically
iterate through all the combinations of options.  Maybe we could also
think about whether we can define some build environment options to
specify devices to use and this could all be run automatically from
'make kselftest'.  Thanks,

Alex

> +
> +function remove_id() {
> +	echo "Removing ${1} from ${2}"
> +	echo $(echo ${1} | tr : ' ') > ${2}/remove_id
> +}
> +
> +function cleanup() {
> +	if [ "${new_driver}" ]; then unbind ${bdf} ${new_driver} ; fi
> +	if [ "${new_id}"     ]; then remove_id ${device_id} ${VFIO_PCI_DRIVER} ; fi
> +	if [ "${old_driver}" ]; then bind ${bdf} ${old_driver} ; fi
> +	if [ "${old_numvfs}" ]; then set_sriov_numvfs ${bdf} ${old_numvfs} ; fi
> +}
> +
> +function usage() {
> +	echo "usage: $0 [-d segment:bus:device.function] [-s] [-h] [cmd ...]" >&2
> +	echo >&2
> +	echo "  -d: The BDF of the device to use for the test (required)" >&2
> +	echo "  -h: Show this help message" >&2
> +	echo "  -s: Drop into a shell rather than running a command" >&2
> +	echo >&2
> +	echo "   cmd: The command to run and arguments to pass to it." >&2
> +	echo "        Required when not using -s. The SBDF will be " >&2
> +	echo "        appended to the argument list." >&2
> +	exit 1
> +}
> +
> +function main() {
> +	while getopts "d:hs" opt; do
> +		case $opt in
> +			d) bdf="$OPTARG" ;;
> +			s) shell=true ;;
> +			*) usage ;;
> +		esac
> +	done
> +
> +	# Shift past all optional arguments.
> +	shift $((OPTIND - 1))
> +
> +	# Check that the user passed in the command to run.
> +	[ ! "${shell}" ] && [ $# = 0 ] && usage
> +
> +	# Check that the user passed in a BDF.
> +	[ "${bdf}" ] || usage
> +
> +	trap cleanup EXIT
> +	set -e
> +
> +	test -d /sys/bus/pci/devices/${bdf}
> +
> +	device_id=$(lspci -s ${bdf} -n | cut -d' ' -f3)
> +
> +	if [ -f /sys/bus/pci/devices/${bdf}/sriov_numvfs ]; then
> +		old_numvfs=$(cat /sys/bus/pci/devices/${bdf}/sriov_numvfs)
> +		set_sriov_numvfs ${bdf} 0
> +	fi
> +
> +	if [ -L /sys/bus/pci/devices/${bdf}/driver ]; then
> +		old_driver=$(readlink -m /sys/bus/pci/devices/${bdf}/driver)
> +		unbind ${bdf} ${old_driver}
> +	fi
> +
> +	# Add the device ID to vfio-pci. If it hasn't already been added, this will
> +	# succeed and bind the device to vfio-pci. If it has already been added, this
> +	# will fail and we have to manually bind the device.
> +	if add_id ${device_id} ${VFIO_PCI_DRIVER}; then
> +		new_id=true
> +	else
> +		bind ${bdf} ${VFIO_PCI_DRIVER}
> +	fi
> +
> +	new_driver=${VFIO_PCI_DRIVER}
> +
> +	echo
> +	if [ "${shell}" ]; then
> +		echo "Dropping into ${SHELL} with BDF=${bdf}"
> +		BDF=${bdf} ${SHELL}
> +	else
> +		"$@" ${bdf}
> +	fi
> +	echo
> +}
> +
> +main "$@"


