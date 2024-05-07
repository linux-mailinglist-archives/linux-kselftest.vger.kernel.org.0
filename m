Return-Path: <linux-kselftest+bounces-9580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2408BDCF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84541F2177E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1113C83A;
	Tue,  7 May 2024 08:10:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476113B7AF
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069430; cv=none; b=HGGj2NfP04Q5UlHidK7rW/ycgnBOtRn5mOAIY6sEbh4493A4XLDclggNHikjjKF4hQcEDxJc4i8WRGwOKeM5I+AAy7vtE3975Fw0WQQoSKB+jMUqvKSSTUNJ8pD3s/EJQoERC2AGTLRODzORocdFF81sBI0IKIDhTOSC7ZUn33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069430; c=relaxed/simple;
	bh=jTkQ2oHkgrxfh36TeRiIIbjWG8m6rDerANzQ6w/pY10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QtrCGYeWaNoNpVyUv6Ye62xO2ZfSA/avE7XxUc0mhKovHqaWs6W5EHnWL42WlSZvPeIAKIPSNUnbrHCmAdnWndEv56zoujO2De6JeHz6bLykoZ4c8KZSH6GVkVCPu5iaQkoIrj2AtwoGVHpv3c96yILuKIi/yRBB+pU4GsgJEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-DB0ZtvnFNuy02KVPE8Zoug-1; Tue,
 07 May 2024 04:10:22 -0400
X-MC-Unique: DB0ZtvnFNuy02KVPE8Zoug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C4073803512;
	Tue,  7 May 2024 08:10:22 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E998C3C27;
	Tue,  7 May 2024 08:10:19 +0000 (UTC)
Date: Tue, 7 May 2024 10:10:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 2/2] selftests/net: add ICMP unreachable over
 IPsec tunnel
Message-ID: <Zjnh6vrHH47L05uY@hog>
References: <cover.1714982035.git.antony.antony@secunet.com>
 <053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <053f57d79058138d09a0e606c0500a40cb78596d.1714982035.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antony,

2024-05-06, 10:05:54 +0200, Antony Antony wrote:
> diff --git a/tools/testing/selftests/net/xfrm_state.sh b/tools/testing/se=
lftests/net/xfrm_state.sh
> new file mode 100755
> index 000000000000..26eac013abcf
> --- /dev/null
> +++ b/tools/testing/selftests/net/xfrm_state.sh
[...]
> +run_test() {
> +=09(
> +=09tname=3D"$1"
> +=09tdesc=3D"$2"
> +
> +
> +=09unset IFS
> +
> +=09fail=3D"yes"
> +
> +=09# Since cleanup() relies on variables modified by this sub shell, it
> +=09# has to run in this context.
> +=09trap cleanup EXIT
> +
> +=09if [ "$VERBOSE" -gt 0 ]; then
> +=09=09printf "\n########################################################=
#############\n\n"
> +=09fi
> +
> +=09# if errexit was not set, set it and unset after test eval
> +=09errexit=3D0
> +=09if [[ $- =3D~ "e" ]]; then
> +=09=09errexit=3D1
> +=09else
> +=09=09set -e
> +=09fi
> +
> +=09eval test_${tname}
> +=09ret=3D$?
> +=09fail=3D"no"
> +=09[ $errexit -eq 0 ] && set +e # hack until exception is fixed

What needs to be fixed?


> +
> +setup_namespace() {

Is this one actually used? I can't find a reference to "namespace"
(singular) in this script.

> +=09setup_ns NS_A
> +=09ns_a=3D"ip netns exec ${NS_A}"
> +}
> +


> +veth_add() {
> +=09local ns_cmd=3D$(nscmd $1)
> +=09local tn=3D"veth${2}1"
> +=09local ln=3D${3:-eth0}
> +=09run_cmd ${ns_cmd} ip link add ${ln} type veth peer name ${tn}

Why not just create the peer directly in the correct namespace and
with the correct name? That would avoid the mess of moving/renaming
with veth_mv, and the really hard to read loop in setup_veths.

> +}

[...]
> +
> +setup_vm_set_v4x() {
> +=09ns_set=3D"a r1 s1 r2 s2 b" # Network topology: x
> +=09imax=3D6

It would be more robust to set ns_set, imax, and all other parameters
in every setup, so that the right topology is always used even if the
test order changes. Currently I'm not sure which topology is used in
which test, except the ones that use setup_vm_set_v4x and
setup_vm_set_v6x.

> +=09prefix=3D${prefix4}
> +=09s=3D"."
> +=09S=3D"."
> +=09src=3D"10.1.3.1"
> +=09dst=3D"10.1.4.2"
> +=09src_net=3D"10.1.1.0/24"
> +=09dst_net=3D"10.1.5.0/24"
> +=09prefix_len=3D24
> +
> +=09vm_set
> +}

[...]
> +setup_veths() {
> +=09i=3D1
> +=09for ns in ${ns_active}; do
> +=09=09[ ${i} =3D ${imax} ] && continue

IIUC imax should be the last, so s/continue/break/ ?

> +=09=09veth_add ${ns} ${i}
> +=09=09i=3D$((i + 1))
> +=09done
> +
> +=09j=3D1
> +=09for ns in ${ns_active}; do
> +=09=09if [ ${j} -eq 1 ]; then
> +=09=09=09p=3D${ns};
> +=09=09=09pj=3D${j}
> +=09=09=09j=3D$((j + 1))
> +=09=09=09continue
> +=09=09fi
> +=09=09veth_mv ${ns} "${p}" ${pj}
> +=09=09p=3D${ns}
> +=09=09pj=3D${j}
> +=09=09j=3D$((j + 1))
> +=09done
> +}
> +
> +setup_routes() {
> +=09ip1=3D""
> +=09i=3D1
> +=09for ns in ${ns_active}; do
> +=09=09# 10.1.C.1/24
> +=09=09ip0=3D"${prefix}${s}${i}${S}1/${prefix_len}"
> +=09=09[ "${ns}" =3D b ] && ip0=3D""
> +=09=09setup_addr_add ${ns} "${ip0}" "${ip1}"
> +=09=09# 10.1.C.2/24
> +=09=09ip1=3D"${prefix}${s}${i}${S}2/${prefix_len}"
> +=09=09i=3D$((i + 1))

This loop is really hard to follow :/
It would probably be easier to read if setup_addr_add only installed
exactly one address (instead of conditionally adding maybe 2), and
checking here whether the address needs to be added ("${ns}" !=3D b,
i -ne 1).

> +=09done
> +
> +=09i=3D1
> +=09nhr=3D""
> +=09for ns in ${ns_active}; do
> +=09=09nhf=3D"${prefix}${s}${i}${S}2"
> +=09=09[ "${ns}" =3D b ] && nhf=3D""
> +=09=09route_add ${ns} "${nhf}" "${nhr}" ${i}
> +=09=09nhr=3D"${prefix}${s}${i}${S}1"
> +=09=09i=3D$((i + 1))

I'd suggest the same here, split route_add into
route_add_{forward,reverse} and only call the right one (or both) for
the current iteration.

> +=09done
> +}

[...]
> +setup() {
> +=09[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_=
skip
> +
> +=09for arg do
> +=09=09eval setup_${arg} || { echo "  ${arg} not supported"; return 1; }
> +=09done
> +}
> +
> +trace() {

Unused?

> +=09[ $TRACING -eq 0 ] && return

Then you can also get rid of that variable at the top.


[...]
> +mtu() {
> +=09ns_cmd=3D"${1}"
> +=09dev=3D"${2}"
> +=09mtu=3D"${3}"
> +
> +=09${ns_cmd} ip link set dev ${dev} mtu ${mtu}
> +}
> +
> +mtu_parse() {
> +=09input=3D"${1}"
> +
> +=09next=3D0
> +=09for i in ${input}; do
> +=09=09[ ${next} -eq 1 -a "${i}" =3D "lock" ] && next=3D2 && continue
> +=09=09[ ${next} -eq 1 ] && echo "${i}" && return
> +=09=09[ ${next} -eq 2 ] && echo "lock ${i}" && return
> +=09=09[ "${i}" =3D "mtu" ] && next=3D1
> +=09done
> +}
> +
> +link_get() {
> +=09ns_cmd=3D"${1}"
> +=09name=3D"${2}"
> +
> +=09${ns_cmd} ip link show dev "${name}"
> +}
> +
> +link_get_mtu() {
> +=09ns_cmd=3D"${1}"
> +=09name=3D"${2}"
> +
> +=09mtu_parse "$(link_get "${ns_cmd}" ${name})"
> +}

All those also seem completely unused by this script. Please don't
just c/p from other selftests without checking.

--=20
Sabrina


