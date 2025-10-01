Return-Path: <linux-kselftest+bounces-42649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF314BAFA9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F919189B039
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9C27D771;
	Wed,  1 Oct 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kerq8nor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B01494CC;
	Wed,  1 Oct 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307878; cv=none; b=oe55HPjw5d8jnsxh9ueyjLqUR2EOuFFzKYr4QN+QV2qm+jvYik2marIpNdIdRyzrjSIVFd6X3D//gXNoNfxCtpt8qJRkinWCpvOFWNuImXArHAvnj3IiZFP4gZ8KBaBEReLMxMgd0viUiv5PTBEQgkKXzQFGphilIs/f9X7KjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307878; c=relaxed/simple;
	bh=mg8UiB6wdQGu3zTb7R5Wx/V4adl+iymRXpWpAYP0EnI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Y3dV1rb6MiXvRfpm3SaaW6GtYNiqaX/SWt6lsW9fXB6nw+hIN752yGojuMCIRWutGAhf4gSZav2uT8Z43Qb84p6qoaPb/ogt4YPGMs97AhzyT2Xvc7+ePEgTYh4+MglfPdxuVhbtuYbktqdjTJihXgXzj+7zeA+cUlDQwUEoYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kerq8nor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25932C4CEF4;
	Wed,  1 Oct 2025 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759307878;
	bh=mg8UiB6wdQGu3zTb7R5Wx/V4adl+iymRXpWpAYP0EnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kerq8norwwc65nplji5P06vHUAQ72Go4jlHXy4Vr/kQXEF4bjxVipZliXk3DCIQpc
	 V8FK64RGZNGTQqEruN47FWy+BxQhQ4xnYB4yciKrkoBcsv84kSkjt/GyxSD5wpWasg
	 9lDLgHdmVnNW2HCkI1lNe48zRRF6sdiZGmEttCCL7XmImweKYzfVQPku68RmlJd0cx
	 Lzff2UBRG1lI/gxyqLxjKGAtmInC9fD4ScpW4lDUExm4AifovmJkXTZig4l/JxpqIH
	 LFIqe2r63nDWu9nH50hAiLX1A2yCJUDl2yDwSAGhy85OybKbKX8t98rSDhT2uyJFy8
	 PsVfsXO2WQpXQ==
Content-Type: multipart/mixed; boundary="------------CcZe0S5aOE1mEgDfh6XW0NWA"
Message-ID: <f4f61cb1-a2f5-4105-b051-0b16427fb12b@kernel.org>
Date: Wed, 1 Oct 2025 10:37:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add ipsec offload test:
 manual merge
Content-Language: en-GB, fr-BE
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
References: <20250925023304.472186-1-liuhangbin@gmail.com>
 <20250925023304.472186-2-liuhangbin@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250925023304.472186-2-liuhangbin@gmail.com>

This is a multi-part message in MIME format.
--------------CcZe0S5aOE1mEgDfh6XW0NWA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 25/09/2025 04:33, Hangbin Liu wrote:
> This introduces a test for IPSec offload over bonding, utilizing netdevsim
> for the testing process, as veth interfaces do not support IPSec offload.
> The test will ensure that the IPSec offload functionality remains operational
> even after a failover event occurs in the bonding configuration.
> 
> Here is the test result:
> 
> TEST: bond_ipsec_offload (active_slave eth0)                        [ OK ]
> TEST: bond_ipsec_offload (active_slave eth1)                        [ OK ]
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3: fix shellcheck errors
> v2: rebase to latest net, no code update
> ---
>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>  .../drivers/net/bonding/bond_ipsec_offload.sh | 156 ++++++++++++++++++
>  .../selftests/drivers/net/bonding/config      |   4 +
>  3 files changed, 162 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 44b98f17f8ff..c13ef40e7db1 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -11,7 +11,8 @@ TEST_PROGS := \
>  	bond_options.sh \
>  	bond-eth-type-change.sh \
>  	bond_macvlan_ipvlan.sh \
> -	bond_passive_lacp.sh
> +	bond_passive_lacp.sh \
> +	bond_ipsec_offload.sh

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  99e4c35eada9 ("selftests: bonding: add ipsec offload test")

and this one from 'net-next':

  c2377f1763e9 ("selftests: bonding: add test for LACP actor port priority")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, I simply added the new files from both trees:

  bond_passive_lacp.sh \
  bond_ipsec_offload.sh \
  bond_lacp_prio.sh

Note: A way to reduce such conflicts in the future is to sort each entry
by alphabetical order instead of adding new ones at the end. Same in the
'config' file that is also modified in this patch.

Rerere cache is available in [2].

1: https://github.com/multipath-tcp/mptcp_net-next/commit/f6c62892b853
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/65a75

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------CcZe0S5aOE1mEgDfh6XW0NWA
Content-Type: text/x-patch; charset=UTF-8;
 name="f6c62892b853cd5ddc6d4ceb41e732bc2e0d0c12.patch"
Content-Disposition: attachment;
 filename="f6c62892b853cd5ddc6d4ceb41e732bc2e0d0c12.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcv
TWFrZWZpbGUKaW5kZXggMzQ2Mjc4M2VkM2FjLGMxM2VmNDBlN2RiMS4uZjk4NGQ3ZGJiYTBh
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcvTWFr
ZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvYm9uZGlu
Zy9NYWtlZmlsZQpAQEAgLTEyLDcgLTEyLDcgKzEyLDggQEBAIFRFU1RfUFJPR1MgOj0gCiAg
CWJvbmQtZXRoLXR5cGUtY2hhbmdlLnNoIFwKICAJYm9uZF9tYWN2bGFuX2lwdmxhbi5zaCBc
CiAgCWJvbmRfcGFzc2l2ZV9sYWNwLnNoIFwKIC0JYm9uZF9pcHNlY19vZmZsb2FkLnNoCisr
CWJvbmRfaXBzZWNfb2ZmbG9hZC5zaCBcCiArCWJvbmRfbGFjcF9wcmlvLnNoCiAgCiAgVEVT
VF9GSUxFUyA6PSBcCiAgCWxhZ19saWIuc2ggXAo=

--------------CcZe0S5aOE1mEgDfh6XW0NWA--

