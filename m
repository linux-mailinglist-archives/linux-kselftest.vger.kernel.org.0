Return-Path: <linux-kselftest+bounces-21597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D279C018B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652952841E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8A1F472F;
	Thu,  7 Nov 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="kOnF0Yae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01080102.me.com (qs51p00im-qukt01080102.me.com [17.57.155.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C81EE011
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973128; cv=none; b=BvYOEBxOG6EVLmWqwBd62kJXZI6vyx8568vIm7rdxuDIhC0y59zlzuiRlp1mzVbkHpjDYF4QtHRBH9vMSyUzFhgg/wLW4XTKQe+/6aoohTN2Yl/DcbGGZpH48qmbGWSLDPgttmAF3okKX8unLlC7rlGkEgYUArznOZP8nsxZB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973128; c=relaxed/simple;
	bh=XYuFnIepnndk9QOOiP/4eU/+0PbxkTgLeKcEbhROGf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ceZ/UBBY+fhAa2g+5frt2fnbCfoLzKwR7QiGqMju/Q7DJ7e89LTJTyMnvT3hGq/K3Ld7i/y1FCCYfGCh6v/xvj8U2KxGZdDW0ApT/rswqlqBZIyJ/Upz6Oe2+GqehPa3cpF9LzwpArC15BBMhccbJIrpgZxqIvC/qWXVH2JXnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=kOnF0Yae; arc=none smtp.client-ip=17.57.155.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730973124; bh=CWiWzBq41hUrLeTAkge2loUB53Gytuq4Kp4AhxvqGGQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 x-icloud-hme;
	b=kOnF0Yae/m/wgGZJ/loJIIgJGvk/C2iK9GhUxIaBGY7yIe+5ZGa0VEWgFldPpbLun
	 bb7yVojmpAodYvXMRfgxWnFzgol4w4LTKTt/iY5hIRHvW2gr1wpUtMYxLOqu2z7Wu1
	 EufdKs3AEpoS3PrJRNMZeiGC3digQqLudPqvXgrWUBx/CA45LNF9FWyfn3e+0Q1CMo
	 FcEAC6YP51wKtKW6gi/2gUPtwVhS6IbQHdtJzoj7bpjKTx9zV3a6AFr2ELy9HCIP9k
	 eITciGgfKFPP0n3/WJLuSnA7KKoJ2AhJ2xFlqu/lkpdtLYRPeMz6WdY4q38xpXa2uf
	 RMo9BsvSueB+A==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080102.me.com (Postfix) with ESMTPSA id CB5D61CC00EC;
	Thu,  7 Nov 2024 09:51:59 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 12:51:56 +0300
Message-Id: <D5FURBXG9EC0.2MKP63RO0JXV2@verdict.gg>
Cc: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <linux-kselftest@vger.kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
 <horms@kernel.org>, <gnault@redhat.com>
Subject: Re: [PATCH net-next v8] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Ido Schimmel" <idosch@idosch.org>
X-Mailer: aerc 0.18.2
References: <20241106133012.289861-1-deliran@verdict.gg>
 <ZyyE473qDbLiPgx7@shredder>
In-Reply-To: <ZyyE473qDbLiPgx7@shredder>
X-Proofpoint-GUID: XwwnGARZ70Cig_aqA9aPNTbvc-xpYitL
X-Proofpoint-ORIG-GUID: XwwnGARZ70Cig_aqA9aPNTbvc-xpYitL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxlogscore=340
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070042

On Thu Nov 7, 2024 at 12:14 PM MSK, Ido Schimmel wrote:
> On Wed, Nov 06, 2024 at 01:30:07PM +0000, Vladimir Vdovin wrote:
> > +test_pmtu_ipv4_mp_exceptions() {
> > +	setup namespaces routing multipath || return $ksft_skip
> > +
> > +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> > +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> > +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> > +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> > +
> > +	# Set up initial MTU values
> > +	mtu "${ns_a}"  veth_A-R1 2000
> > +	mtu "${ns_r1}" veth_R1-A 2000
> > +	mtu "${ns_r1}" veth_R1-B 1500
> > +	mtu "${ns_b}"  veth_B-R1 1500
> > +
> > +	mtu "${ns_a}"  veth_A-R2 2000
> > +	mtu "${ns_r2}" veth_R2-A 2000
> > +	mtu "${ns_r2}" veth_R2-B 1500
> > +	mtu "${ns_b}"  veth_B-R2 1500
> > +
> > +	fail=3D0
> > +
> > +	# Ping and expect two nexthop exceptions for two routes in nh group
> > +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
> > +
> > +	# Do route lookup before checking cached exceptions.
> > +	# The following commands are needed for dst entries to be cached
> > +	# in both paths exceptions and therefore dumped to user space
> > +	# Check that exceptions have been created with the correct PMTU
> > +	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr=
}" oif veth_A-R1)"
> > +	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr=
}" oif veth_A-R2)"
>
> This overrides the first PMTU
>
> > +
> > +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || retu=
rn 1
> > +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || retu=
rn 1
> > +
> > +	return ${fail}
>
> And "fail" does not seem to be used anymore.
>
> Can you squash the following diff to v9?
Thanks again! Sent v9
And seems that v10 will come next day, cause I did not apply your diff and =
forgot to
remove fail=3D0 :/

>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index 9e34b54d9c15..1b4d4c598d66 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2396,22 +2396,14 @@ test_pmtu_ipv4_mp_exceptions() {
>  	mtu "${ns_r2}" veth_R2-B 1500
>  	mtu "${ns_b}"  veth_B-R2 1500
> =20
> -	fail=3D0
> -
>  	# Ping and expect two nexthop exceptions for two routes in nh group
>  	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
> =20
> -	# Do route lookup before checking cached exceptions.
> -	# The following commands are needed for dst entries to be cached
> -	# in both paths exceptions and therefore dumped to user space
>  	# Check that exceptions have been created with the correct PMTU
>  	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}"=
 oif veth_A-R1)"
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return=
 1
>  	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}"=
 oif veth_A-R2)"
> -
>  	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return=
 1
> -	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return=
 1
> -
> -	return ${fail}
>  }
> =20
>  usage() {


