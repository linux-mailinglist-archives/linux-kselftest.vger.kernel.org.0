Return-Path: <linux-kselftest+bounces-935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AA80030C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F81C20CD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55816FC4;
	Fri,  1 Dec 2023 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="EvycvNBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnulShBV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63191703;
	Thu, 30 Nov 2023 21:35:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4ADB95C01EE;
	Fri,  1 Dec 2023 00:35:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 01 Dec 2023 00:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701408901; x=1701495301; bh=GF
	bRhbSjB9oLO+LwKHE9kfWx3hJNKnD7jw8ytn4NBfc=; b=EvycvNBF7h8MZ6ztIM
	N1Yw39AfbJCGyaHfRtQ0veDNHIG/xx6lD3NYOexhB57vSyED6ehfQPo6f575fQIi
	cbFwa1Zho3FR2gIBaI/7qlf+7TybxpsFRBqk2eRLBrMykydGfrSF/wlmOTm9Lz3/
	ph0w1UlFz/Qq1yCKlRDdfYp2Jjk+2c+279sbr/vaBxU3mI9Iel+9B7sIgTB1+f/D
	4wclfbtzxBclbTy6sBBErBQydzdYKGRrZnzhaq1LuMqqIC9jkNVN999UHAtLhLUk
	X2GyMKEXJVlcQgaLCGDU51E2O4ojElNjOvYM0xpSnPlrkIqh3x90AuoBk4ZqdNKy
	m+KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701408901; x=1701495301; bh=GFbRhbSjB9oLO
	+LwKHE9kfWx3hJNKnD7jw8ytn4NBfc=; b=OnulShBVdt4nTEhF0acVUc1GBaps6
	XUmxAV6jfI5bDBbJ6RWpCWVob1mNNNwCAsD/DCst2pcogoKIXqqzsgtfiSC2rBD3
	Cqg/XYb5M5MnGzegr/xP9ywz8WyMCkLUuTSYiFkHkDGo3TJRiyfM9+R1HfSDffTl
	56onQbPYSTaFGeD+fF2zlHepE/nsVrjXeHystVR4LEKTnL7RTbCkaXfOo3YeVgk9
	7MhdQ4W4JwOIIRYg6Gx5UheX3adrObhvdfBUZ+/oTb1EnK3CMK7H48sQrcuz4+Q6
	Dt2SN5g3OUeP//THcWVZs1T1RAT77Of0ah8ym3T/oQ5y/+cGGppObAM1Q==
X-ME-Sender: <xms:hXBpZfjbiQJ2q5TYvTwMA8NH7jYsFSYEjq-DXvtdbpfzPahjWwAAbg>
    <xme:hXBpZcCU6RBDAhHY1rRzmhXntfd42M3MI6e0NdPjGfQBPB5hfvoYUqzcF8sxz6iiv
    QDpYrgiXpDjpL0Px2Y>
X-ME-Received: <xmr:hXBpZfEteadm9DhObeTPRuG-lVYCavoBNEmwM8TEzLFEdqR53NAt53FPLEXjSAPaQagy_E4RlqWg-XUqK8qqTHZMP1aA9hJvR5ux>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:hXBpZcSB7soGlszoalFU7aqqGh8dUx_GwSxz3AnzagYCPrZ5DC7Siw>
    <xmx:hXBpZcwcF4XxcwS-zQDsXprnK2pKTsd3IaERoffCTr5evbozaOaf7w>
    <xmx:hXBpZS4nrWO-LxShSqQLRkWHkdfFhV73Yk86g90is6KqJ0zgU7otaA>
    <xmx:hXBpZbqHjd1e5LngYLB0ofa0i5RcN2n_8EzQxC27ewNHaCgU8FpLiA>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 00:34:57 -0500 (EST)
Date: Fri, 1 Dec 2023 15:34:52 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] selftests/hid: vmtest.sh: allow finer control on
 the build steps
Message-ID: <20231201053452.GA625212@quokka>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
 <20231129-wip-selftests-v1-2-ba15a1fe1b0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-wip-selftests-v1-2-ba15a1fe1b0d@kernel.org>

On Wed, Nov 29, 2023 at 04:24:27PM +0100, Benjamin Tissoires wrote:
> vmtest.sh works great for a one shot test, but not so much for CI where
> I want to build (with different configs) the bzImage in a separate
> job than the one I am running it.
> 
> Add a "build_only" option to specify whether we need to boot the currently
> built kernel in the vm.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/vmtest.sh | 42 ++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
> index 301b4e162336..52ada972833b 100755
> --- a/tools/testing/selftests/hid/vmtest.sh
> +++ b/tools/testing/selftests/hid/vmtest.sh
> @@ -32,7 +32,7 @@ DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS
>  usage()
>  {
>  	cat <<EOF
> -Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
> +Usage: $0 [-j N] [-s] [-b] [-d <output_dir>] -- [<command>]
>  
>  <command> is the command you would normally run when you are in
>  the source kernel direcory. e.g:
> @@ -55,6 +55,7 @@ Options:
>  
>  	-u)		Update the boot2container script to a newer version.
>  	-d)		Update the output directory (default: ${OUTPUT_DIR})
> +	-b)		Run the only build steps for the kernel and the selftests

typo: "run only the"

Cheers,
  Peter


>  	-j)		Number of jobs for compilation, similar to -j in make
>  			(default: ${NUM_COMPILE_JOBS})
>  	-s)		Instead of powering off the VM, start an interactive
> @@ -191,8 +192,9 @@ main()
>  	local command="${DEFAULT_COMMAND}"
>  	local update_b2c="no"
>  	local debug_shell="no"
> +	local build_only="no"
>  
> -	while getopts ':hsud:j:' opt; do
> +	while getopts ':hsud:j:b' opt; do
>  		case ${opt} in
>  		u)
>  			update_b2c="yes"
> @@ -207,6 +209,9 @@ main()
>  			command="/bin/sh"
>  			debug_shell="yes"
>  			;;
> +		b)
> +			build_only="yes"
> +			;;
>  		h)
>  			usage
>  			exit 0
> @@ -226,8 +231,7 @@ main()
>  	shift $((OPTIND -1))
>  
>  	# trap 'catch "$?"' EXIT
> -
> -	if [[ "${debug_shell}" == "no" ]]; then
> +	if [[ "${build_only}" == "no" && "${debug_shell}" == "no" ]]; then
>  		if [[ $# -eq 0 ]]; then
>  			echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
>  		else
> @@ -267,24 +271,26 @@ main()
>  	update_kconfig "${kernel_checkout}" "${kconfig_file}"
>  
>  	recompile_kernel "${kernel_checkout}" "${make_command}"
> +	update_selftests "${kernel_checkout}" "${make_command}"
>  
> -	if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
> -		echo "vm2c script not found in ${b2c}"
> -		update_b2c="yes"
> -	fi
> +	if [[ "${build_only}" == "no" ]]; then
> +		if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
> +			echo "vm2c script not found in ${b2c}"
> +			update_b2c="yes"
> +		fi
>  
> -	if [[ "${update_b2c}" == "yes" ]]; then
> -		download $B2C_URL $b2c
> -		chmod +x $b2c
> -	fi
> +		if [[ "${update_b2c}" == "yes" ]]; then
> +			download $B2C_URL $b2c
> +			chmod +x $b2c
> +		fi
>  
> -	update_selftests "${kernel_checkout}" "${make_command}"
> -	run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
> -	if [[ "${debug_shell}" != "yes" ]]; then
> -		echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
> -	fi
> +		run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
> +		if [[ "${debug_shell}" != "yes" ]]; then
> +			echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
> +		fi
>  
> -	exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
> +		exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
> +	fi
>  }
>  
>  main "$@"
> 
> -- 
> 2.41.0
> 

