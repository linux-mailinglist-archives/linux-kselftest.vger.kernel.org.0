Return-Path: <linux-kselftest+bounces-46860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3668C996F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 23:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6B345986
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01901245005;
	Mon,  1 Dec 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Um0G9v2a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585211FDA;
	Mon,  1 Dec 2025 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629367; cv=none; b=OK7V9hxOoRTKfaslARAP9EQ5VMWQN+oq8g+1yTm7D/Kh8clF7zMLf3dfAi0B3cbsptGjz5m/sFsxJINSW7G8XDS0s5d6XvNl6numW2/Y7SthCbdURn46SK6Os9PkPld6hr+F5/vtF5iae9JHDYSpSVz8rVVB1OOol5zJkxLUhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629367; c=relaxed/simple;
	bh=o08e3lndV4MmlSuouTwyGZ31ekryd2dZD37SZxIHuME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmOKDFYZ5JgiFEgwY20KMLoCtgbsC2Va9Ee63MoVJz+elJLVeBahsIS11qQHpRGg6+bjQD+uVZwiYc5N6P6P5q/uOMG94D/XhZ0Re5qMLRadbg6JX7gkkvqrvp+7ywmKg75WvbfV7egXHDCJHnhyTc3ZJduFt73A/vZmHBxa2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Um0G9v2a; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1LJS7s4118138;
	Mon, 1 Dec 2025 14:49:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VG6uM2PSbf+3AJaJoRbbI3+C9CIZH9n9KAeQNJ7qCFE=; b=Um0G9v2ae4OF
	gBkogoxMf45y8xPMXeASwfICnGRnq5V9NBz/ntUjiRPE5SrFlj8YDYXRg2NR/p1B
	SrlUtrNhRGbqEa2aOrzMHYKhjMODgRFS5Ozv1EXNPgKWd2ThEDXzKLzqyCyZQTtu
	ZFRf29+3OmXbE/YiHUjDQg3BOjkD1mz10z6wUbrIYLxPdvLWc+nMTwM9zVJHtOWE
	5KlVH0b0jfCMwHj2x+hhZwg437nFrYU8bACRsHccQN+kq/pE6S54WtdwZGGHz5t9
	Eu9p4yefsepdj0N5JUBclJfscHO5/ZJke4AdLwfuxOwzCr1oDN6aAb7YMbhvzi4k
	/r7MqXRFNQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4asju5rnfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 01 Dec 2025 14:49:12 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 1 Dec 2025 22:49:10 +0000
From: Chris Mason <clm@meta.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
CC: Chris Mason <clm@meta.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with existing 8021q upper on any port
Date: Mon, 1 Dec 2025 14:48:48 -0800
Message-ID: <20251201224855.4102774-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAOiHx=mog+8Grm1QTnqU_F3=BnWmJqTj+ko-nZiRMAb4-hvSqw@mail.gmail.com>
References:
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y0O8RzpyZELpb6ptQ4FoQgQymNIEJbUa
X-Authority-Analysis: v=2.4 cv=EvnfbCcA c=1 sm=1 tr=0 ts=692e1b68 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=crjk6GUWDzGwglwjZYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5hNPEnYuNAgA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: Y0O8RzpyZELpb6ptQ4FoQgQymNIEJbUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE4MyBTYWx0ZWRfXzm1T2yuII93v
 mXBuPNVJWfpBO6Dq9B8IQytaYfizIEqi/B8r4xyezbkPeqYRvbRaLcbKx17BCZt5y5bshqMv60O
 8pYpx9PdtmeRPByYtNJyx8D8NXGeBRMFHZvEMHsi0gYA32G3y5TSNNIIFB7s0NX60vi6enI0TU9
 S5ThvBnJ9Ya2AX16Js6AjTgBAYHMbsbZfrqK1TsSZL9cnn5Mnap6JuE6BrvqY73fYUMs24IKHLK
 u+rUEL8SNgt89R4Uvu63n8XQGAdEURt8qtRVbTMBsUboQ3Vr9MyIGkHfiyvZblviDwjkvrJMhPj
 jAIp9jmtlMsk/u0VXX0bC/sZrTVDAqok2YgBnMLg9KMwRmX8fEm31do7oYX5EMoAFyj9CxvwnYt
 GIvIk8BKytuYmB4W/3dO67vXpDFIUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

On Mon, 1 Dec 2025 20:52:34 +0100 Jonas Gorski <jonas.gorski@gmail.com> wrote:

> Hi,
> 
> On Mon, Dec 1, 2025 at 3:48 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Dec 01, 2025 at 11:28:13AM +0100, Jonas Gorski wrote:
> >
> > ...
> >
> > > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > > index f59d66f0975d..fa1fe0f1493a 100644
> > > --- a/net/dsa/user.c
> > > +++ b/net/dsa/user.c
> > > @@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
> > >
> > >  /* Must be called under rcu_read_lock() */
> > >  static int
> > > -dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
> > > +dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
> > >                                    const struct switchdev_obj_port_vlan *vlan)
> > >  {
> > > -     struct net_device *upper_dev;
> > > -     struct list_head *iter;
> > > +     struct dsa_switch *ds = dp->ds;
> > > +     struct dsa_port *other_dp;
> > >
> > > -     netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
> > > -             u16 vid;
> > > +     dsa_switch_for_each_user_port(other_dp, ds) {
> > > +             struct net_device *user = other_dp->user;
> >
> > Hi Jonas,
> >
> > The AI robot is concerned that user may be NULL here.
> > And I can't convince myself that cannot be the case.
> >
> > Could you take a look?
> >
> > https://netdev-ai.bots.linux.dev/ai-review.html?id=47057e-e740-4b66-9d60-9ec2a7ee92a1#patch-0
> 
> At this point it can be NULL. But it being NULL is not an issue, as ...
> >
> > > +             struct net_device *upper_dev;
> > > +             struct list_head *iter;
> > >
> > > -             if (!is_vlan_dev(upper_dev))
> > > +             if (!dsa_port_bridge_same(dp, other_dp))
> > >                       continue;
> 
> ... this condition will filter all cases where it is NULL. For
> dsa_port_bridge_same() to return true both ports need to be attached
> to a bridge (and to the same bridge), and to be attached to a bridge a
> net_device is required, so other_dp->user cannot be NULL. And we only
> access user after here.

I reproduced this false positive here, thanks for the explanation.  This is an
example of a class of review mistakes I've wanted to fix, so I used it to
improve the prompts around NULL pointers that are protected via other checks.

I'll test this on some more commits and push it out.

-chris

