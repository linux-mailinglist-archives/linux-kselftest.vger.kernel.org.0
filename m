Return-Path: <linux-kselftest+bounces-29506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B4A6AB57
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CBF98030E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728821D3E2;
	Thu, 20 Mar 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/79YFaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19E1EB5E0;
	Thu, 20 Mar 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489197; cv=none; b=WvTXgjZv9J59DCBBLyB81hVZ6HgZE52vYco/76dbUvVsheeQnbnKewI2nOE9U7Q+zyEFgBrPTv3onwe647eErTNG2wwxrSru2+J2UmD0qLKy9IH40h0GM3WbZDDv7osUNA6811mbm5LZSfu4FgUBCXih+X6JICI/g1qlYu8R4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489197; c=relaxed/simple;
	bh=lXinkjipf1en7622TJq1al7bKgl10Rm49aHznKd8Phw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FyUpzQ+cLrisbFDvzO0yWqru2zZ1okpMG9eyTZtC9xxHj853+UzV2VDSiaJdSgn5O6HpvzndUC5iZHXEK0ZdUxUmxcwsVA1hnQW2w0SVVCg07Lv+TCuPiwXHA4TUdzHBY8D+NHyH+0/CJeTT4V0PA/ruffYXnod4jiV8sEQ3XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/79YFaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C0C4CEDD;
	Thu, 20 Mar 2025 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489196;
	bh=lXinkjipf1en7622TJq1al7bKgl10Rm49aHznKd8Phw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/79YFaHCpNer9yH9sjA//ici6kmkfbzVBJZ9Sv0lTT9sW3dAknaA7xwTpEZT9dV3
	 mSmbYJza3s+sv4Ky7kDrKMiMGAYF0VYx1l+71rNtsxkkl+sQtJKtajowLEEvTqgaam
	 lu2rKHDyDFw4DlOD1a4L/g6Pe2gJyJxeZ7cZuJbAwsBdc8+0V5rHOVuX0PMoL4aLpk
	 76UuqPBARI+wROhJyIVEluN7oaUyFk/K48lq5Puw0sxSWpyybqrAH1dXEOLfOnAe4e
	 50rk/9oscVKAB3DXtiBKIuSzoBZosk62J/nkv9hd/J19eyTq87/65SbpuRAtmqxNmu
	 8CIoaxHvYdcCQ==
Content-Type: multipart/mixed; boundary="------------df9TvLEoGeNXbwgvcfLcFC5D"
Message-ID: <7ba23e8b-d103-4788-9b9c-2d5521ac07b6@kernel.org>
Date: Thu, 20 Mar 2025 17:46:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 3/3] selftests: net: test for lwtunnel dst ref
 loops: manual merge
Content-Language: en-GB, fr-BE
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250314120048.12569-1-justin.iurman@uliege.be>
 <20250314120048.12569-4-justin.iurman@uliege.be>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250314120048.12569-4-justin.iurman@uliege.be>

This is a multi-part message in MIME format.
--------------df9TvLEoGeNXbwgvcfLcFC5D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Justin,

On 14/03/2025 13:00, Justin Iurman wrote:
> As recently specified by commit 0ea09cbf8350 ("docs: netdev: add a note
> on selftest posting") in net-next, the selftest is therefore shipped in
> this series. However, this selftest does not really test this series. It
> needs this series to avoid crashing the kernel. What it really tests,
> thanks to kmemleak, is what was fixed by the following commits:
> - commit c71a192976de ("net: ipv6: fix dst refleaks in rpl, seg6 and
> ioam6 lwtunnels")
> - commit 92191dd10730 ("net: ipv6: fix dst ref loops in rpl, seg6 and
> ioam6 lwtunnels")
> - commit c64a0727f9b1 ("net: ipv6: fix dst ref loop on input in seg6
> lwt")
> - commit 13e55fbaec17 ("net: ipv6: fix dst ref loop on input in rpl
> lwt")
> - commit 0e7633d7b95b ("net: ipv6: fix dst ref loop in ila lwtunnel")
> - commit 5da15a9c11c1 ("net: ipv6: fix missing dst ref drop in ila
> lwtunnel")
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/config            |   2 +
>  .../selftests/net/lwt_dst_cache_ref_loop.sh   | 246 ++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 5916f3b81c39..843ab747645d 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -101,6 +101,7 @@ TEST_PROGS += vlan_bridge_binding.sh
>  TEST_PROGS += bpf_offload.py
>  TEST_PROGS += ipv6_route_update_soft_lockup.sh
>  TEST_PROGS += busy_poll_test.sh
> +TEST_PROGS += lwt_dst_cache_ref_loop.sh
>  
>  # YNL files, must be before "include ..lib.mk"
>  YNL_GEN_FILES := busy_poller netlink-dumps
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 5b9baf708950..61e5116987f3 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -107,3 +107,5 @@ CONFIG_XFRM_INTERFACE=m
>  CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
> +CONFIG_IPV6_ILA=m
> +CONFIG_IPV6_RPL_LWTUNNEL=y

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

 3ed61b8938c6 ("selftests: net: test for lwtunnel dst ref loops")

and these ones from 'net-next':

 03544faad761 ("selftest: net: add proc_net_pktgen")
 85cb3711acb8 ("selftests: net: Add test cases for link and peer netns")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding these conflicts, that's because the new test and configs have
been added at the end. It is usually recommended to avoid that for long
list, e.g. inserting new entries at the right place if the list is
sorted by alphabetical order (not the case here), grouping by theme, or
keeping the same order as in the .config, etc. For the resolutions here,
I simply kept the new tests and configs from both sides at the same
place, adding the new ones from net at the end.

Rerere cache is available in [2].

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/89220b9164c7
[2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/d240

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------df9TvLEoGeNXbwgvcfLcFC5D
Content-Type: text/x-patch; charset=UTF-8;
 name="89220b9164c70f7aa2d3fafab261bb196f8f3335.patch"
Content-Disposition: attachment;
 filename="89220b9164c70f7aa2d3fafab261bb196f8f3335.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9NYWtlZmlsZQppbmRleCBm
MDNhMDM5OWU3YTMsOGYzMmI0ZjAxYWVlLi42ZDcxOGI0NzhlZDgKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL25ldC9NYWtlZmlsZQpAQEAgLTMxLDE1IC0zMSwxMSArMzEsMTQgQEBAIFRFU1RfUFJP
R1MgKz0gdmV0aC5zCiAgVEVTVF9QUk9HUyArPSBpb2FtNi5zaAogIFRFU1RfUFJPR1MgKz0g
Z3JvLnNoCiAgVEVTVF9QUk9HUyArPSBncmVfZ3NvLnNoCi0gVEVTVF9QUk9HUyArPSBncmVf
aXB2Nl9sbGFkZHIuc2gKICBURVNUX1BST0dTICs9IGNtc2dfc29fbWFyay5zaAogIFRFU1Rf
UFJPR1MgKz0gY21zZ19zb19wcmlvcml0eS5zaAogLVRFU1RfUFJPR1MgKz0gY21zZ190aW1l
LnNoIGNtc2dfaXB2Ni5zaAogK1RFU1RfUFJPR1MgKz0gdGVzdF9zb19yY3Yuc2gKICtURVNU
X1BST0dTICs9IGNtc2dfdGltZS5zaCBjbXNnX2lwLnNoCiAgVEVTVF9QUk9HUyArPSBuZXRu
cy1uYW1lLnNoCiArVEVTVF9QUk9HUyArPSBsaW5rX25ldG5zLnB5CiAgVEVTVF9QUk9HUyAr
PSBubF9uZXRkZXYucHkKICtURVNUX1BST0dTICs9IHJ0bmV0bGluay5weQogIFRFU1RfUFJP
R1MgKz0gc3J2Nl9lbmRfZHQ0Nl9sM3Zwbl90ZXN0LnNoCiAgVEVTVF9QUk9HUyArPSBzcnY2
X2VuZF9kdDRfbDN2cG5fdGVzdC5zaAogIFRFU1RfUFJPR1MgKz0gc3J2Nl9lbmRfZHQ2X2wz
dnBuX3Rlc3Quc2gKQEBAIC0xMDUsNyAtMTAwLDcgKzEwNCw4IEBAQCBURVNUX1BST0dTICs9
IHZsYW5fYnJpZGdlX2JpbmRpbmcucwogIFRFU1RfUFJPR1MgKz0gYnBmX29mZmxvYWQucHkK
ICBURVNUX1BST0dTICs9IGlwdjZfcm91dGVfdXBkYXRlX3NvZnRfbG9ja3VwLnNoCiAgVEVT
VF9QUk9HUyArPSBidXN5X3BvbGxfdGVzdC5zaAogK1RFU1RfR0VOX1BST0dTICs9IHByb2Nf
bmV0X3BrdGdlbgorIFRFU1RfUFJPR1MgKz0gbHd0X2RzdF9jYWNoZV9yZWZfbG9vcC5zaAog
IAogICMgWU5MIGZpbGVzLCBtdXN0IGJlIGJlZm9yZSAiaW5jbHVkZSAuLmxpYi5tayIKICBZ
TkxfR0VOX0ZJTEVTIDo9IGJ1c3lfcG9sbGVyIG5ldGxpbmstZHVtcHMKZGlmZiAtLWNjIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9jb25maWcKaW5kZXggYjBkMGVkYTgyOWQwLDYx
ZTUxMTY5ODdmMy4uMTMwZDUzMmI3ZTY3Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L25ldC9jb25maWcKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2NvbmZpZwpA
QEAgLTEwOSw5IC0xMDcsNSArMTA5LDExIEBAQCBDT05GSUdfWEZSTV9JTlRFUkZBQ0U9CiAg
Q09ORklHX1hGUk1fVVNFUj1tCiAgQ09ORklHX0lQX05GX01BVENIX1JQRklMVEVSPW0KICBD
T05GSUdfSVA2X05GX01BVENIX1JQRklMVEVSPW0KICtDT05GSUdfSVBWTEFOPW0KICtDT05G
SUdfQ0FOPW0KICtDT05GSUdfQ0FOX0RFVj1tCiArQ09ORklHX0NBTl9WWENBTj1tCiArQ09O
RklHX05FVEtJVD15CiArQ09ORklHX05FVF9QS1RHRU49bQorIENPTkZJR19JUFY2X0lMQT1t
CisgQ09ORklHX0lQVjZfUlBMX0xXVFVOTkVMPXkK

--------------df9TvLEoGeNXbwgvcfLcFC5D--

