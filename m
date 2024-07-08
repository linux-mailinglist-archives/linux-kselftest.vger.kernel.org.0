Return-Path: <linux-kselftest+bounces-13330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F492A9D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02A21F2279B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3D1CD1F;
	Mon,  8 Jul 2024 19:32:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276C79FD;
	Mon,  8 Jul 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467136; cv=none; b=C1TELwx4ZA67IXIFLy/pyBih3zORZMNLmhQIDeXohRp7fQD5I5tLcXkdoyy3FzUx2S9Wt8ErcaSJCdgSNygx+c2oeOIC/iWJNH9Zloz1JJWvTxtqReaC1inIzdV7c1p2yK9WwYWeCB5Hod4C9DxcdIp2bpvynnzBN+b6Ie+oovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467136; c=relaxed/simple;
	bh=f8U5dwa1tcDAE9u6GF0FKU/4zaD9eRSS/JNLzhMMRfM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s7QnTTPSuRrDq9ZOXUl83nS0k9rErDANshNHR0Zy20jMj2YjKjxGjO7qaYD7hFnfeWVWL9d75hTGmDB/WCIKlFsmEecSmI7UCeVlD9xmOJ+236nHXdqrIKmJmntlFR7iF57WiiG/7XKCFFskXHzOazWAPYbqpu0rPJ7ffLrGq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5BD420002;
	Mon,  8 Jul 2024 19:31:59 +0000 (UTC)
Message-ID: <0fd40aed-04d1-43a3-ab3d-c7459a63f753@ovn.org>
Date: Mon, 8 Jul 2024 21:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dev@openvswitch.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [ovs-dev] [PATCH v1] selftests: openvswitch: retry instead of
 sleep
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240708134451.3489802-1-amorenoz@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240708134451.3489802-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 7/8/24 15:44, Adrian Moreno wrote:
> There are a couple of places where the test script "sleep"s to wait for
> some external condition to be met.
> 
> This is error prone, specially in slow systems (identified in CI by
> "KSFT_MACHINE_SLOW=yes").
> 
> To fix this, add a "ovs_wait" function that tries to execute a command
> a few times until it succeeds. The timeout used is set to 5s for
> "normal" systems and doubled if a slow CI machine is detected.
> 
> This should make the following work:
> 
> $ vng --build  \
>     --config tools/testing/selftests/net/config \
>     --config kernel/configs/debug.config
> 
> $ vng --run . --user root -- "make -C tools/testing/selftests/ \
>     KSFT_MACHINE_SLOW=yes TARGETS=net/openvswitch run_tests"
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 49 ++++++++++++++++---
>  .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 

Hi, Adrian.  See a small pile of nitpicks below.

None of them are blocking from my perspective, except for a typo.
Just listed them since there is a typo anyway.

> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index bc71dbc18b21..83407b42073a 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -11,6 +11,7 @@ ksft_skip=4
>  PAUSE_ON_FAIL=no
>  VERBOSE=0
>  TRACING=0
> +WAIT_TIMEOUT=5
>  
>  tests="
>  	arp_ping				eth-arp: Basic arp ping between two NS
> @@ -29,6 +30,32 @@ info() {
>  	[ $VERBOSE = 0 ] || echo $*
>  }
>  
> +ovs_wait() {
> +	info "waiting $WAIT_TIMEOUT s for: $@"
> +
> +	"$@"
> +	if [[ $? -eq 0 ]]; then

Maybe just 'if "$@"; then' ?

> +		info "wait succeeded inmediately"

* immediately

> +		return 0
> +	fi
> +
> +	# A quick re-check helps speed up small races in fast systems.
> +	# However, fractional sleeps might not necessarily work.
> +	local start=0
> +	sleep 0.1 || { sleep 1; start=1; }
> +
> +	for (( i=start; i<WAIT_TIMEOUT; i++ )); do

for i in $(seq ${start} ${WAIT_TIMEOUT}); do

Will need to initialize start to 1 and 2.

It works, but seems like an unnecessary use of non-POSIX constructs.

> +		"$@"
> +		if [[ $? -eq 0 ]]; then

if "$@"; then

> +			info "wait succeeded after $i seconds"
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +	info "wait failed after $i seconds"
> +	return 1
> +}
> +
>  ovs_base=`pwd`
>  sbxs=
>  sbx_add () {
> @@ -278,20 +305,21 @@ test_psample() {
>  
>  	# Record psample data.
>  	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-events
> +	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
>  
>  	# Send a single ping.
> -	sleep 1
>  	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
> -	sleep 1
>  
>  	# We should have received one userspace action upcall and 2 psample packets.
> -	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
> +	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out
> +	[[ $? -eq 0 ]] || return 1

Why checking separately and not one the same line with || return 1 ?
Also double brackets seem unnecessary.

>  
>  	# client -> server samples should only contain the first 14 bytes of the packet.
> -	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> -	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> +	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" $ovs_dir/stdout
> +	[[ $? -eq 0 ]] || return 1
> +
> +	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/stdout
> +	[[ $? -eq 0 ]] || return 1

Same for above two.

>  
>  	return 0
>  }
> @@ -711,7 +739,8 @@ test_upcall_interfaces() {
>  	ovs_add_netns_and_veths "test_upcall_interfaces" ui0 upc left0 l0 \
>  	    172.31.110.1/24 -u || return 1
>  
> -	sleep 1
> +	ovs_wait grep -q "listening on upcall packet handler" ${ovs_dir}/left0.out
> +
>  	info "sending arping"
>  	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
>  	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
> @@ -811,6 +840,10 @@ shift $(($OPTIND-1))
>  IFS="	
>  "
>  
> +if test "X$KSFT_MACHINE_SLOW" == "Xyes"; then
> +	WAIT_TIMEOUT=10
> +fi

Should this be done closer to the first initialization of WAIT_TIMEOUT ?

> +
>  for arg do
>  	# Check first that all requested tests are available before running any
>  	command -v > /dev/null "test_${arg}" || { echo "=== Test ${arg} not found"; usage; }
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 1e15b0818074..8a0396bfaf99 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -2520,6 +2520,7 @@ class PsampleEvent(EventSocket):
>      marshal_class = psample_msg
>  
>      def read_samples(self):
> +        print("listening for psample events", flush=True)
>          while True:
>              try:
>                  for msg in self.get():


