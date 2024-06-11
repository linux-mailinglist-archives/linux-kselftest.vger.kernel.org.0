Return-Path: <linux-kselftest+bounces-11679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B84903E55
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 16:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB321C22CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0C17D372;
	Tue, 11 Jun 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlQ6gn0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D001DFF8
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114679; cv=none; b=FjEqT55BoGyL8dv3ZFNVB0INOaSzoFsaC9WL6qiQCh8naf0HKXXEYZcjXy7q9FflLPIYGAqBObuUw+v/NxuIBTpzhGw+oLYGSELWWeQunpKwaLSb4rHI4p+DEI0tauot9CzfsoegVX35ksn5ZO9rBzWt1vUL5i+FHo/KHj9fBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114679; c=relaxed/simple;
	bh=trGiPJjAG5Lg9A+UiUTAr6m2HCDMuWyJu8Xi/VJCwmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4unIkec8/toNUTT++39BcjEe1IXGql1WWhgMetIngoFFR9f1uLpzBfU8SHNxEJ6QwajA3PDr+xYNMbd+WnSz2HIcl6B1unB3lr2GrvylYt+HlwU4fotztqH62OrPIhCUpoP6JLFXUsOxO7xqnY/mKUlLDSZdAuoqCKti6ciTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlQ6gn0J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718114676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAPflhf5z7yrHuZp8DNchU9pFtrCYnF+364utpEHSM8=;
	b=YlQ6gn0JQUhDSSeyVOh40G+0AscSj4GODkE2DAZc+j78feyE0oRkxvvY6DHD4JEz3vAP2a
	qnzRJHKJUTQdo0pbTQlFAJNmcfl+6pwHrPc5glur0eeXxLYVrZraJE99eiFHrW6mZLb8tz
	0ZRosL7Pyh+SyTkf6uUTKGXud1i/CjI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-HJAMWWwDOJS9XCUUIumP0Q-1; Tue,
 11 Jun 2024 10:04:34 -0400
X-MC-Unique: HJAMWWwDOJS9XCUUIumP0Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE43E1955D82;
	Tue, 11 Jun 2024 14:04:23 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BC9A1955E80;
	Tue, 11 Jun 2024 14:04:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Simon
 Horman <horms@verge.net.au>
Subject: Re: [PATCH net-next 1/2] selftests: openvswitch: fix action formatting
In-Reply-To: <CAG=2xmNU4i5LwrfaSBNKODyOaR0OqVdxX3B5xhkrkNQX2v=S3Q@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Thu, 6 Jun 2024 09:05:01
 +0000")
References: <20240603183121.2305013-1-amorenoz@redhat.com>
	<f7ta5k126oc.fsf@redhat.com>
	<CAG=2xmNU4i5LwrfaSBNKODyOaR0OqVdxX3B5xhkrkNQX2v=S3Q@mail.gmail.com>
Date: Tue, 11 Jun 2024 10:04:14 -0400
Message-ID: <f7tsexjpodd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Mon, Jun 03, 2024 at 03:00:03PM GMT, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>> > In the action formatting function ("dpstr"), the iteration is made over
>> > the nla_map, so if there are more than one attribute from the same type
>> > we only print the first one.
>> >
>> > Fix this by iterating over the actual attributes.
>> >
>> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> > ---
>> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 48 +++++++++++--------
>> >  1 file changed, 27 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/to=
ols/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > index 1dd057afd3fb..b76907ac0092 100644
>> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > @@ -437,40 +437,46 @@ class ovsactions(nla):
>> >      def dpstr(self, more=3DFalse):
>> >          print_str =3D ""
>> >
>> > -        for field in self.nla_map:
>> > -            if field[1] =3D=3D "none" or self.get_attr(field[0]) is N=
one:
>> > +        for attr_name, value in self["attrs"]:
>> > +            attr_desc =3D next(filter(lambda x: x[0] =3D=3D attr_name=
, self.nla_map),
>> > +                             None)
>> > +            if not attr_desc:
>> > +                raise ValueError("Unknown attribute: %s" % attr)
>> > +
>> > +            attr_type =3D attr_desc[1]
>> > +
>> > +            if attr_type =3D=3D "none":
>>
>> I agree, this is an issue.  BUT I think it might be better to just
>> filter by field type up front.  See:
>>
>> https://github.com/apconole/linux-next-work/commit/7262107de7170d44b6dbf=
6c5ea6f7e6c0bb71d36#diff-3e72e7405c6bb4e9842bed5f63883ca930387086bb40d4034e=
92ed83a5decb4bR441
>>
>> That version I think ends up being much easier to follow.  If you want
>> to take it for your series, feel free.  If you disagree, maybe there's
>> something I'm not considering about it.
>>
>
> I agree. It's better to check field attribute names first. I found this
> during manual testing of the "emit_sample" series but I ended up not
> needing it for the automated one, so I'm OK waiting for your cleanup
> series.

I'll get stuff out this week for it.

> In fact, I also have some patches that try some rework of this part. In
> particular, I tried to unify all attributes under a common base class
> that would handle printing and parsing. That way, most cases would fall
> into "print_str +=3D datum.dpstr(more)" and the "if/elif" block would
> shrink significantly.

That sounds very good.

>> NOTE that version is just a bunch of independent changes that are
>> squashed together.  I have a cleaner version.
>>
>> I can also bundle up the series I have so far and submit, but I didn't
>> want to do that until I got all the pmtu.sh support working.  Maybe it
>> makes sense to send it now though.  Simon, Jakub - wdyt?
>>
>> >                  continue
>> >              if print_str !=3D "":
>> >                  print_str +=3D ","
>> >
>> > -            if field[1] =3D=3D "uint32":
>> > -                if field[0] =3D=3D "OVS_ACTION_ATTR_OUTPUT":
>> > -                    print_str +=3D "%d" % int(self.get_attr(field[0]))
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_RECIRC":
>> > -                    print_str +=3D "recirc(0x%x)" % int(self.get_attr=
(field[0]))
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_TRUNC":
>> > -                    print_str +=3D "trunc(%d)" % int(self.get_attr(fi=
eld[0]))
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_DROP":
>> > -                    print_str +=3D "drop(%d)" % int(self.get_attr(fie=
ld[0]))
>> > -            elif field[1] =3D=3D "flag":
>> > -                if field[0] =3D=3D "OVS_ACTION_ATTR_CT_CLEAR":
>> > +            if attr_type =3D=3D "uint32":
>> > +                if attr_name =3D=3D "OVS_ACTION_ATTR_OUTPUT":
>> > +                    print_str +=3D "%d" % int(value)
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_RECIRC":
>> > +                    print_str +=3D "recirc(0x%x)" % int(value)
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_TRUNC":
>> > +                    print_str +=3D "trunc(%d)" % int(value)
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_DROP":
>> > +                    print_str +=3D "drop(%d)" % int(value)
>> > +            elif attr_type =3D=3D "flag":
>> > +                if attr_name =3D=3D "OVS_ACTION_ATTR_CT_CLEAR":
>> >                      print_str +=3D "ct_clear"
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_VLAN":
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_POP_VLAN":
>> >                      print_str +=3D "pop_vlan"
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_ETH":
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_POP_ETH":
>> >                      print_str +=3D "pop_eth"
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_NSH":
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_POP_NSH":
>> >                      print_str +=3D "pop_nsh"
>> > -                elif field[0] =3D=3D "OVS_ACTION_ATTR_POP_MPLS":
>> > +                elif attr_name =3D=3D "OVS_ACTION_ATTR_POP_MPLS":
>> >                      print_str +=3D "pop_mpls"
>> >              else:
>> > -                datum =3D self.get_attr(field[0])
>> > -                if field[0] =3D=3D "OVS_ACTION_ATTR_CLONE":
>> > +                if attr_name =3D=3D "OVS_ACTION_ATTR_CLONE":
>> >                      print_str +=3D "clone("
>> > -                    print_str +=3D datum.dpstr(more)
>> > +                    print_str +=3D value.dpstr(more)
>> >                      print_str +=3D ")"
>> >                  else:
>> > -                    print_str +=3D datum.dpstr(more)
>> > +                    print_str +=3D value.dpstr(more)
>> >
>> >          return print_str
>>


