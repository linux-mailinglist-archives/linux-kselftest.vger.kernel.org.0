Return-Path: <linux-kselftest+bounces-26342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D66A3073F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A20162C41
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D954A1F12F8;
	Tue, 11 Feb 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="duPBoovO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E31C1F02;
	Tue, 11 Feb 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266604; cv=none; b=m8tj2osP/nXE9meQ5Bs7JC0rhwSFGjWdcuLs+z4G9aj8Y/d0f7t5YArwem6pSrT+aDn5KEkrnuXrRMqFiyBD1g0ypsdfUhyPwViI9LktEKv0uSoPXzbVZ3FcWDZNiIVo1sZp78j6qzptt4j/j2MVjWDmi0LjqsIXHpJFV4zr68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266604; c=relaxed/simple;
	bh=r0t/C/JtKU2oJus6ciVO1PV/Kw3upXfkSpsHfmJsvBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh1YEPs8JlzP99pJrcJ59rNe0wCkCdEbomV3H/1ebV4p7S8Ln3Uw5qszt/yF9mSKgIRstHbds8kEJKHbkqNrt2rDX9kkwtJBflwV9k6GGu9xtOB91XfXetc7r26P0qu1DhDlfvgE5nT81ugNVKSZi+mGoaDMFcB5ks86nosMD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=duPBoovO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739266599; x=1739871399; i=ps.report@gmx.net;
	bh=xlQvqMlLEpURsovZTD7C/j2+VnCZle44LOF8c3QimJE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=duPBoovOiuxmoDZAW4/mJtbxo7poIoUEtNT2QpHLGDfJgO0HKUprMIpwPS8DQttz
	 2fdb+5LhRDlUDFruRAlKDYO+7ktb+9wN8nT7ELLLSld8MtU1A+6ZxwpLoAPFMw2hQ
	 R3vYhvfc9je71OBfkqLU+X8XmkdNbKaZiKc1MGll2qoibvoZz7jU/AGYkA03O1r2t
	 R3KxSLV14n+L7yl5xNITK8m7xFJqal141p7IL6gvJ4vpG5lXcRXdRrJbNfeL8Wexc
	 G8hgyTBRVkvF5lnfpOzNfKte8Zcd+uZDH7Hw7+yS8juZFubcRvSKs3ZcNTZuZ1pPd
	 7bUusGJ6YINqL3rC1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1ttgwE2xdl-00SRi0; Tue, 11
 Feb 2025 10:36:39 +0100
Date: Tue, 11 Feb 2025 10:36:39 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 00/17] Some pktgen fixes/improvments
Message-ID: <20250211103639.531a2baa@gmx.net>
In-Reply-To: <20250206135154.GB641369@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
	<20250206135154.GB641369@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5LxLtIQPMMSImztDiDIFP6uroR6HuR/ZlyTZHQCIF+Q3o2qbC+
 ruwC2AL/oxaQi38o5N4HS7P6lhRTAEevw1rgISozxqlFXhsFOQjDc07PDYcc6Q0E0mCuKKc
 2oBZ5rs2zNOT5reATE8O6f5cU24eq9ci8C1/sw2X+q6PN4U9Q6Z2IxV5BLrdvh467cgijcL
 FmBJUmvhk0PQHmoyOeB2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FxWfTdx8fhM=;hGa3vGXg8c4iVmcNLq1pnJrcxa1
 bFre4qds7Yht4y0xV5IqFJ49CfC8k/VrP1NoGD22oLax/yPKnLZxhPKAfMzg9uMsctpZexHHg
 N3SDGEdBPctl9KdmPZBrAMKYa4fLAUZkAHSTgIWMJNiOCPQamsktpmixtruAt7l7nGHKZR2tV
 5nZd8/CpHA/djmh1ZRHflXdgLEWy73dlPuOwhvqz+3+K2yL3HtTpd35mUvGKcMHX1RX5yxoFy
 UyRRYJD8li4cLbdfiXVPHsHwgcyeQjh4lCVRWBVsH02yNGvdvJ93lxUqoBMxxZLzpCo8D/JCa
 mQk/mfCbTNySaLxXgTCTxVpj2L4gSgggAsGJAserfhDx3jmRuDxvDI167IlDqZU1D1TQJsvw9
 7KkhQYLLeHiKV+GWVsIweMvE6iVn5j+Ye3tV4K8sHBTV3WxRMPq/KCEM6LTdejAoqltV8Vur7
 DiIY3MvROqU0TIwQvASqJQyIHkjCtX2bb75AduX/BRL3VnTgdmzSbsgN6zd9MpD8Kyfu99Ktn
 +61gfGP/EbK4DqS2RAYL0hg2ktBF+7Tp6UBMquldBr5UFLhjN5dj2+49Mm0GnbK4Vhf4sBHfM
 Bscc33DNNvWOVrUUPrMOqsDJcDTuAYDzBWh7CnIbSRmEnjkStdRWYy1Yfi7W1pcp6sHqJC4st
 2fuw31KoKOJC0PPcYkHiX+adagTwIydHYX7+Fg6d6feLmj8o5i6XBDnknrKIWNOvekf7kuRAR
 GhyNuMEpkhXNBPNPmvIoGjTrNh2aVbIwNwxEBWOeqnP/177n+wfG6sj+2tuubxIokblDWj0th
 d/9j8oVrOCx8/O3biRJEGYbU4XReSsa5YUOsABRPK/ZiSpCFCyddYBlOSkJELCX9nzoc5LVW9
 3rFVe3pp+nFSQJZr+ZpbLCOUYY6PZEWgDUExq01b3LzS2vIzvEVGEilsInojvx3Q9ZWEJYqab
 2AeN97VDSUp5CjECTKRbifkX8V/O8FtdGksyV8vlEaLCh/y4M8bxVfjKFfi1CiH1QODymcNPm
 pQm6GVD0xGoxKuZgozkYj8QTdyjGg3tSWrZB3yCVNOfwBilQgyNkFd75nDfVLpBAZChfCF6pZ
 DPdQpv1g76fhApBDEdSVZVcdtFp6sMqjIcFDM8Mao6cTbAF6abIVY2EIiIiy5AyJ46Iyd+xRH
 dv9gWjsz2pu9qHz9nVAxJt2HJK2iAWPUoF/2PJ+R69+GIlpOw//kStBr2poUt9eUWxgmyzdyZ
 3HgIBaHsn9TJV855+LhzVqOmLSNPIHteEtB9oOQXYh4VYxk7dL9sY+OsH0P2kfFa387kRGegQ
 P7f+KrEiZF8EVt7GGM98bCmAyft+dB1u1uWbKW1bPoIkxPjSvyIjFlYBrtp+546F6aGKi080O
 B+aqV1U21VpY08uHwt0xU2LY+swjR/mxnrHg9UAFzdZ1YsO0TdEAmDK0xQ

Hello Simon,

On Thu, 6 Feb 2025 13:51:54 +0000, Simon Horman <horms@kernel.org> wrote:

> On Wed, Feb 05, 2025 at 02:11:36PM +0100, Peter Seiderer wrote:
> > hile taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> > get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bound=
s access
> > in get_imix_entries' ([2], [3]) and doing some tests and code review I
> > detected that the /proc/net/pktgen/... parsing logic does not honour t=
he
> > user given buffer bounds (resulting in out-of-bounds access).
> >
> > This can be observed e.g. by the following simple test (sometimes the
> > old/'longer' previous value is re-read from the buffer):
> >
> >         $ echo add_device lo@0 > /proc/net/pktgen/kpktgend_0
> >
> >         $ echo "min_pkt_size 12345" > /proc/net/pktgen/lo\@0 && grep m=
in_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> > Result: OK: min_pkt_size=3D12345
> >
> >         $ echo -n "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep =
min_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> > Result: OK: min_pkt_size=3D12345
> >
> >         $ echo "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min=
_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 123  max_pkt_size: 0
> > Result: OK: min_pkt_size=3D123
> >
> > So fix the out-of-bounds access (and some minor findings) and add a si=
mple
> > proc_net_pktgen selftest...
> >
> > Regards,
> > Peter
> >
> > Changes v3 -> v4:
> >  - add rev-by Simon Horman
> >  - new patch 'net: pktgen: use defines for the various dec/hex number =
parsing
> >    digits lengths' (suggested by Simon Horman)
> >  - replace C99 comment (suggested by Paolo Abeni)
> >  - drop available characters check in strn_len() (suggested by Paolo A=
beni)
> >  - factored out patch 'net: pktgen: align some variable declarations t=
o the
> >    most common pattern' (suggested by Paolo Abeni)
> >  - factored out patch 'net: pktgen: remove extra tmp variable (re-use =
len
> >    instead)' (suggested by Paolo Abeni)
> >  - factored out patch 'net: pktgen: remove some superfluous variable
> >    initializing' (suggested by Paolo Abeni)
> >  - factored out patch 'net: pktgen: fix mpls maximum labels list parsi=
ng'
> >    (suggested by Paolo Abeni)
> >  - factored out 'net: pktgen: hex32_arg/num_arg error out in case no
> >    characters are available' (suggested by Paolo Abeni)
> >  - factored out 'net: pktgen: num_arg error out in case no valid chara=
cter
> >    is parsed' (suggested by Paolo Abeni)
>
> Hi Peter,
>
> Thanks for splitting up the patchset some more, I for one find it much
> easier to review them in this form.

Definitely!

>
> That said, we are now over the preferred maximum of 15 patches in a seri=
es.
> Perhaps the maintainers are ok with that, but I'd like to suggest breaki=
ng
> the series in two: The first 7 patches seem to be somewhat stable, from =
a
> review perspective, and could be posted as "part i"; And then the remain=
ing
> patches could be posted as "part ii" once "part i" has been accepted.

Yes, the patch set evolved a little bit over the 'just fix some little str=
ange
behavior'..., splitting it up will work for me for sure..., will do on nex=
t
patch set iteration...

Regards,
Peter

>
> As for the selftests (the last patch of the series). A version,
> trimmed down as appropriate, could be included in "part i", with a
> follow-up in "part ii". Or the cover note for "part i" could state that =
the
> selftests have been deferred to "part ii".
>
> Perhaps the maintainers have other ideas, if so hopefully they will comm=
ent
> here.


