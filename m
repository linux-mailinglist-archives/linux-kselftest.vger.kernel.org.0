Return-Path: <linux-kselftest+bounces-18895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFE98D2B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD11C21984
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB631CF5E9;
	Wed,  2 Oct 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dgYfgxVJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735451CF5E4;
	Wed,  2 Oct 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870881; cv=none; b=OFYdXRM3x3zUkSKog0iea6fBl6RzagoYttXoLd78IuhCbvgxbnMPQTklx58HsUx4vqs6c57JwAGsZt8kbd/wMP434GRCXuOdi9+eqbO3onofBscjZy3zbkvhN0zZbeAzz+NELtRmaRabe+zN9trltb+PzacRBgDl7qarGzECYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870881; c=relaxed/simple;
	bh=gn4F9pB4na9+7GgpzpyseAb8fGmzrSbQ7CICsquYq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6PIdoiy9qHA5TgicLD7KVN/ApqoWlPQGW7sakv7NPGM5m0jODw9h+jFSDVRPRy/dkJGSbnThmxyxZItWixId/Owiwg03XFu2apLrjTtB0gTzmXvhbEvLiLdjgFIcv1rZpUNn2qmAQ82GiSMAtGlDlliwHJEosoX1+7Xpu1T3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dgYfgxVJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ywfq2v21PV6eapCc1G1aqc4sN2E2b3BC6Na6Mmcquao=; b=dgYfgxVJr1u82vTP9Trk34qgP3
	QhM+J/H3sZWqtFMrzTAXeywDeWzk5NcB/fJHSqYYBo1NiLsJ+nsbFw3tYJ++eDsJ+TfTSEfwqHVGC
	vLt4lxNCMkv1y0FeKtVb5V390tydl2DZdYH8Gchd/mQjpHp+MOzJuNQNsLhCxn8/1pcLhSYHFInsQ
	ir/KcHFqBhmGixGTGFkqbGDgIIAdgjo73yWvPysp2QVPl/L/tWLyPCQtjOmzVBBP8fChGIs733D3K
	vXZOAYYoMXCgf7EhRCjc4MdSolbLm7i6k2cmNMysyHc3aF5FzT0x++2/2IUF3M6dE0SkAr2H8cReW
	zPRU65xw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1svy96-000HPM-4s; Wed, 02 Oct 2024 14:07:55 +0200
Received: from [178.197.249.44] (helo=[192.168.1.114])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1svy94-0006Hb-30;
	Wed, 02 Oct 2024 14:07:55 +0200
Message-ID: <6c80ed1a-6b6f-4920-9b80-a25d8b40cca4@iogearbox.net>
Date: Wed, 2 Oct 2024 14:07:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests, bpf: Skip MPLS test_tc_tunnel tests
 if MPLS is unavailable
To: Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexis.lothore@bootlin.com
References: <20240927-mpls-skip-v1-1-1bc38abf917e@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20240927-mpls-skip-v1-1-1bc38abf917e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27415/Wed Oct  2 10:52:29 2024)

[ +Alexis ]

On 9/27/24 2:05 PM, Simon Horman wrote:
> If MPLS is not available in the kernel then skip MPLS tests.
>
> This avoids the test failing in situations where the test is not
> supported by the underlying kernel.
>
> In the case where all tests are run, just skip over the MPLS tests
> without altering the exit code of the overall test run - there
> is only one exit code in this scenario.
>
> In the case where a single test is run, exit with KSFT_SKIP (4).
>
> In both cases log an informative message.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Are you running this as part of net selftests / CI which is why you
need this? (And if yes, why excluding MPLS?)

Alexis is working on converting tests like these into our BPF CI into
test_progs, I'm not sure whether we need to make that more
complex unless there is a compelling reason to exclude MPLS?

Thanks,
Daniel

> ---
>   tools/testing/selftests/bpf/test_tc_tunnel.sh | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> index 7989ec608454..71cddabc4ade 100755
> --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> @@ -102,6 +102,20 @@ wait_for_port() {
>   	return 1
>   }
>   
> +skip_mac() {
> +	if [ "$1" = "mpls" ]; then
> +		modprobe mpls_iptunnel || true
> +		modprobe mpls_gso || true
> +
> +		if [ ! -e /proc/sys/net/mpls/platform_labels ]; then
> +			echo -e "skip:    mpls tunnel not supported by kernel\n"
> +			return # true
> +		fi
> +	fi
> +
> +	false
> +}
> +
>   set -e
>   
>   # no arguments: automated test, run all
> @@ -125,6 +139,8 @@ if [[ "$#" -eq "0" ]]; then
>   	$0 ipv6 ip6vxlan eth 2000
>   
>   	for mac in none mpls eth ; do
> +		! skip_mac "$mac" || continue
> +
>   		echo "ip gre $mac"
>   		$0 ipv4 gre $mac 100
>   
> @@ -193,6 +209,10 @@ readonly tuntype=$2
>   readonly mac=$3
>   readonly datalen=$4
>   
> +if skip_mac "$mac"; then
> +	exit 4 # KSFT_SKIP=4
> +fi
> +
>   echo "encap ${addr1} to ${addr2}, type ${tuntype}, mac ${mac} len ${datalen}"
>   
>   trap cleanup EXIT
> @@ -278,8 +298,6 @@ elif [[ "$tuntype" =~ (gre|vxlan) && "$mac" == "eth" ]]; then
>   		  awk '/ether/ { print $2 }')
>   	ip netns exec "${ns2}" ip link set testtun0 address $ethaddr
>   elif [[ "$mac" == "mpls" ]]; then
> -	modprobe mpls_iptunnel ||true
> -	modprobe mpls_gso ||true
>   	ip netns exec "${ns2}" sysctl -qw net.mpls.platform_labels=65536
>   	ip netns exec "${ns2}" ip -f mpls route add 1000 dev lo
>   	ip netns exec "${ns2}" ip link set lo up
>
>


