Return-Path: <linux-kselftest+bounces-5359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16A861807
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632F52864F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAB126F2C;
	Fri, 23 Feb 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b80dq8jX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF883A0D;
	Fri, 23 Feb 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706136; cv=none; b=DGWSUQ8QhzIrxVDM/FfSE/1rb1962EohaXB4qeVz2Xhz9HAxP7bQq5HV2z24nLkQt9hEVn6jhMGZUOwlN46ERcmnhcTCwyXCcKj6K+N1rVpYrVY6FuTAPxhudcKb2WDK5koa3E1NVpTg8E8UHSjtUSKJvnDuX0+CL8DLu6QSsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706136; c=relaxed/simple;
	bh=RPr5WYlLx6M3L4Dw9KUBr4Cz5XuyraokgeEyTWWJV1Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qLEb7hviXvZbJbdJno2tgbmE7BcSofEkmOaXIG7qCWSoSQT2xCGwd9u2YDso2tTwrlRr4YRg2E2CL25xNM1nBy0Z2cZgderWhRmvGpWv0lnb3CrrTytypNLDtAAVMcJTP7K6kTsE7y/6Nau67cqfqNWFFHEuYCIGzmwhJAmgdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b80dq8jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A03C433F1;
	Fri, 23 Feb 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706136;
	bh=RPr5WYlLx6M3L4Dw9KUBr4Cz5XuyraokgeEyTWWJV1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b80dq8jX/zrX40B3maeIYgDYTOGPui2gaqVvhE9KIH7jYSsHfZY3IIJ+TIvY8rGDC
	 AAKs59P+pd21UVPmZNrZ63AQXjsCvGjBuWHFDLXwvKDkZhpl1L1dh+AHTCL9MIFGt3
	 gUcldfAJZP/QxiZVyk/kAmNlkeXNB/yyGIxnX6whlMlG1gyBe1LA3K/NU4m1ZUOa/t
	 ZJypPqRsedt7t5Vzmo20eQiYTA0Ez4G7VgImUoECRRdR2EQbizO5gNBMZFNcnCkgTm
	 NDydEzmnx7Ou24bHXuBzfM1CGaTafCopsv05SBSCIiZz5JgTJJjWexY1gm5blFLpOI
	 ORzs+l5spTPUQ==
Content-Type: multipart/mixed; boundary="------------iOB1UcdNFo69IXo0qRTmA46w"
Message-ID: <0585f8a1-e0ca-483d-a21f-20617192cb28@kernel.org>
Date: Fri, 23 Feb 2024 17:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/10] mptcp: fix snd_wnd initialization for passive
 socket: manual merge
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>,
 Peter Krystad <peter.krystad@linux.intel.com>,
 Christoph Paasch <cpaasch@apple.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
 <20240223-upstream-net-20240223-misc-fixes-v1-5-162e87e48497@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-5-162e87e48497@kernel.org>

This is a multi-part message in MIME format.
--------------iOB1UcdNFo69IXo0qRTmA46w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub, Paolo, Stephen,

On 23/02/2024 5:14 pm, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Such value should be inherited from the first subflow, but
> passive sockets always used 'rsk_rcv_wnd'.
> 
> Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 442fa7d9b57a..2c8f931c6d5b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3211,7 +3211,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  	msk->write_seq = subflow_req->idsn + 1;
>  	msk->snd_nxt = msk->write_seq;
>  	msk->snd_una = msk->write_seq;
> -	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> +	msk->wnd_end = msk->snd_nxt + tcp_sk(ssk)->snd_wnd;

Please note that this patch will conflict with the following commit from
net-next:

  3f83d8a77eee ("mptcp: fix more tx path fields initialization")

That's because this commit modifies the same line as the one modified
here. We cannot avoid a conflict here. To fix it, please use
'WRITE_ONCE()' with the new line from -net:

  WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);

A 3-way diff has been attached to this email.

>  	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
>  	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
>  
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
--------------iOB1UcdNFo69IXo0qRTmA46w
Content-Type: text/x-patch; charset=UTF-8;
 name="conflict-mptcp-fix-more-tx-path-fields-initialization.diff"
Content-Disposition: attachment;
 filename*0="conflict-mptcp-fix-more-tx-path-fields-initialization.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC9tcHRjcC9wcm90b2NvbC5jCmluZGV4IDc4MzNhNDlmNjIxNCw5ZGY0
ZWFkZGZkNDguLjAwMDAwMDAwMDAwMAotLS0gYS9uZXQvbXB0Y3AvcHJvdG9jb2wuYworKysg
Yi9uZXQvbXB0Y3AvcHJvdG9jb2wuYwpAQEAgLTMyNDIsMjUgLTMyMDQsMTggKzMyNDcsMjUg
QEBAIHN0cnVjdCBzb2NrICptcHRjcF9za19jbG9uZV9pbml0KGNvbnN0IAogIAogIAlfX21w
dGNwX2luaXRfc29jayhuc2spOwogIAogKyNpZiBJU19FTkFCTEVEKENPTkZJR19NUFRDUF9J
UFY2KQogKwlpZiAobnNrLT5za19mYW1pbHkgPT0gQUZfSU5FVDYpCiArCQltcHRjcF9jb3B5
X2lwNl9vcHRpb25zKG5zaywgc2spOwogKwllbHNlCiArI2VuZGlmCiArCQltcHRjcF9jb3B5
X2lwX29wdGlvbnMobnNrLCBzayk7CiArCiAgCW1zayA9IG1wdGNwX3NrKG5zayk7Ci0gCW1z
ay0+bG9jYWxfa2V5ID0gc3ViZmxvd19yZXEtPmxvY2FsX2tleTsKLSAJbXNrLT50b2tlbiA9
IHN1YmZsb3dfcmVxLT50b2tlbjsKKyAJV1JJVEVfT05DRShtc2stPmxvY2FsX2tleSwgc3Vi
Zmxvd19yZXEtPmxvY2FsX2tleSk7CisgCVdSSVRFX09OQ0UobXNrLT50b2tlbiwgc3ViZmxv
d19yZXEtPnRva2VuKTsKICAJbXNrLT5pbl9hY2NlcHRfcXVldWUgPSAxOwogIAlXUklURV9P
TkNFKG1zay0+ZnVsbHlfZXN0YWJsaXNoZWQsIGZhbHNlKTsKICAJaWYgKG1wX29wdC0+c3Vi
b3B0aW9ucyAmIE9QVElPTl9NUFRDUF9DU1VNUkVRRCkKICAJCVdSSVRFX09OQ0UobXNrLT5j
c3VtX2VuYWJsZWQsIHRydWUpOwogIAotIAltc2stPndyaXRlX3NlcSA9IHN1YmZsb3dfcmVx
LT5pZHNuICsgMTsKLSAJbXNrLT5zbmRfbnh0ID0gbXNrLT53cml0ZV9zZXE7Ci0gCW1zay0+
c25kX3VuYSA9IG1zay0+d3JpdGVfc2VxOwotIAltc2stPnduZF9lbmQgPSBtc2stPnNuZF9u
eHQgKyB0Y3Bfc2soc3NrKS0+c25kX3duZDsKKyAJV1JJVEVfT05DRShtc2stPndyaXRlX3Nl
cSwgc3ViZmxvd19yZXEtPmlkc24gKyAxKTsKKyAJV1JJVEVfT05DRShtc2stPnNuZF9ueHQs
IG1zay0+d3JpdGVfc2VxKTsKKyAJV1JJVEVfT05DRShtc2stPnNuZF91bmEsIG1zay0+d3Jp
dGVfc2VxKTsKIC0JV1JJVEVfT05DRShtc2stPnduZF9lbmQsIG1zay0+c25kX254dCArIHJl
cS0+cnNrX3Jjdl93bmQpOworKwlXUklURV9PTkNFKG1zay0+d25kX2VuZCwgbXNrLT5zbmRf
bnh0ICsgdGNwX3NrKHNzayktPnNuZF93bmQpOwogIAltc2stPnNldHNvY2tvcHRfc2VxID0g
bXB0Y3Bfc2soc2spLT5zZXRzb2Nrb3B0X3NlcTsKICAJbXB0Y3BfaW5pdF9zY2hlZChtc2ss
IG1wdGNwX3NrKHNrKS0+c2NoZWQpOwogIAo=

--------------iOB1UcdNFo69IXo0qRTmA46w--

