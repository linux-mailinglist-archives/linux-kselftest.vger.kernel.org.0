Return-Path: <linux-kselftest+bounces-31532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA22A9AA14
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB32446DBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDBF223DCC;
	Thu, 24 Apr 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKhmpxfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE491221F15;
	Thu, 24 Apr 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490289; cv=none; b=ch/8MeE4sW+QoQ7SHV4yD7Occf/WJ+ezb1cURR6unXTdg2RgytrOweDLnf/PmqdHxBsNx6oTRJCXFKiL5jqlH2tatNjb5I48Ppm6ajBmGj48LTmyTFPqoqvFwOjfEk50L9/NgIwo9nHB3RovE1419doaDITxxte9ALhRxE9ipCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490289; c=relaxed/simple;
	bh=nzlLt7eMrI+PUVGmLSR9BtNHU7ebjb9Q2zzSu55nqk8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=H7IIkbIab33rGkB2Uhdh/4+uQ9G8snWJkgOTXUwb2z4Fi5b3ZGTAMAQVqMz8dBqdbDUSP3Em1jEU7O0w45VRJ53GzAk+99/USwC2bzpS5rtZc6i0Da1p56FqVSqt3EspvSQuRv2vYyqC/1Hk9A/nkEXTGwUvMg0mbYqCAi6/BdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKhmpxfP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c14016868so767774f8f.1;
        Thu, 24 Apr 2025 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490286; x=1746095086; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45PI6cq9lDsalPYrWUG3x0PfMSB8VqbFhmWHvVrE7W4=;
        b=jKhmpxfP7ME+Rpes9/Y/MxUmEVS8N71xuL3f4Fg7nZbehuMoqXa9sYlxzc+rf9MpGI
         h/GBYWnAUXJnhFhaFqGupISjkAx/q9YJZgR3pdY5lPNfwbC5x9iFI4Dfxo2WaHiAENGT
         t7Toe395jCMYyFDeW5V+9hGeGzGQmChyU9oi6RuuaCU2aNFErNhmFrTbsQJtQ4+IRoBG
         Vwp9O6ho+GXIdKcHysplk1MAJzpATVGRKu4pnmfZZMSkGp+AgJOiAPnx8VTm8/OzU43O
         wDxHwUDJ2OVI368XDNewTNciQXt2wCuwuRgi8c2gyhGNbybijtCYjGKH9dqiLfKs+K2p
         3EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490286; x=1746095086;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45PI6cq9lDsalPYrWUG3x0PfMSB8VqbFhmWHvVrE7W4=;
        b=UQgDtVx5c9Dd0SGSz8hEQlcnpPr89tSL29DiKbyWPEbC+oqoaQbwgYFP18+y34PESP
         v5ieHM9k5EJZyKPz502d4fpizFkaYxflqf737gm6Ibr7Fd1Oe6o+JB7yv/G4rKNPrNfB
         0WOwaNOXz582qBkmGvhQlcgptdyDZOG4amDXgnm3qFk/8OInMjb9M2jyXxmt6FjOL3A7
         jA60dn3FZdVZu1fSZoHp/cr24wP30Ut36c85GdCWPWWlJ4+whTwiSWn5jiA6JmftGX3q
         KP0FAE5w4H3OVnR9mt8Xl9/2RviUxVF8BBgz+cJzgHTEPFRz3Joikpjcht6ZsykV0N4n
         Hp2w==
X-Forwarded-Encrypted: i=1; AJvYcCUnA5ynqaHfPBa0erMTjLv6VGkw4w87y/JK0+hZcl6AhBbk2R2YnQBHHKD/jLnKwFdCyur4Gy2Z@vger.kernel.org, AJvYcCWjnJ6cg2qS5QTbmIace/z7cUfMW+nfTp05+21QO1CR/sKRhm6EEpIF65rVSDDiV/YOscY48Ho0hHG42pijndk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8l4RTAgtDUeMdbx0+FSlUGJs+0dJFl/0hSZQwVzwXD9YKSf0P
	6Dsoufi+ePtnefeJfnBq2XGzgijgCIf7HU5r7POqyGx5ko5flECI
X-Gm-Gg: ASbGncs3k+sAe8WpDMqxbYaAdHQ3WIaZ0CRsZz33Gu29ygqK8rXqj+FzV6lAwyRsRul
	xYOOVdFN31qbFaP+qC3LYGALftw/Wsu/GDqavSdLb1HSvGsEoHonzpbEsPmK8wp4ThmTq+PAjrA
	k8x3dD8O3eiKW39u9dexVRBLdyVlrWfyxJet+SeAOfqnRuKztwUg7VcCjdDe75go8hjrqreSUKT
	tE7Qv8y6HG+Z95J2C24qDGs1vv+7J/qj8Hj7iTF5SN8zVt+5HIN8IbXzDfl+PKYKbt6vIJrgMeU
	dCgHF/fQs+HRLjxLy2avI8HHUh5RKY0Ifd1OJlimoSsbIWOCfQiCK81TRQA=
X-Google-Smtp-Source: AGHT+IER6Hy6UkrZLaJLb5OJImyUsbLZiLek/i0WklJWbx4mUMqDWhs0ULRnMmdu05hxy/wjIR9A+Q==
X-Received: by 2002:a05:6000:1a8e:b0:390:f0ff:2c11 with SMTP id ffacd0b85a97d-3a06cf4ed00mr1620841f8f.2.1745490285933;
        Thu, 24 Apr 2025 03:24:45 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7d34:7f0d:292f:fa10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2bf8dbsm15352035e9.35.2025.04.24.03.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:24:45 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "xandfury@gmail.com" <xandfury@gmail.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "dave.taht@gmail.com" <dave.taht@gmail.com>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "jhs@mojatatu.com"
 <jhs@mojatatu.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "stephen@networkplumber.org" <stephen@networkplumber.org>,
  "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
  "jiri@resnulli.us" <jiri@resnulli.us>,  "davem@davemloft.net"
 <davem@davemloft.net>,  "edumazet@google.com" <edumazet@google.com>,
  "horms@kernel.org" <horms@kernel.org>,  "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "ast@fiberby.net" <ast@fiberby.net>,
  "liuhangbin@gmail.com" <liuhangbin@gmail.com>,  "shuah@kernel.org"
 <shuah@kernel.org>,  "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>,  "ij@kernel.org" <ij@kernel.org>,
  "ncardwell@google.com" <ncardwell@google.com>,  "Koen De Schepper
 (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,  g.white
 <g.white@cablelabs.com>,  "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>,  "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>,  "cheshire@apple.com"
 <cheshire@apple.com>,  "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
  "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,  vidhi_goel
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
In-Reply-To: <PAXPR07MB79840FF6B073C61136AC238CA3BA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
	(Chia-Yu Chang's message of "Wed, 23 Apr 2025 17:15:15 +0000")
Date: Thu, 24 Apr 2025 10:26:15 +0100
Message-ID: <m2wmb9syfc.fsf@gmail.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
	<20250422201602.56368-2-chia-yu.chang@nokia-bell-labs.com>
	<m2o6wnt8to.fsf@gmail.com>
	<PAXPR07MB79840FF6B073C61136AC238CA3BA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com> writes:

>> The syntax is not valid so this doesn't pass the schema check and presumably hasn't been tested. Please validate YNL .yaml additions e.g.
>> 
>> ./tools/net/ynl/pyynl/cli.py \
>>     --spec Documentation/netlink/specs/tc.yaml \
>>     --list-ops
>> 
>> ...
>> jsonschema.exceptions.ValidationError: Additional properties are not allowed ('entries' was unexpected) ...
>> On instance['attribute-sets'][30]['attributes'][14]:
>>     {'name': 'gso_split',
>>      'type': 'flags',
>>      'doc': 'Split aggregated skb or not',
>>      'entries': ['split_gso', 'no_split_gso']}
>> 
>
> Hi Donald,
>
> 	Thanks for the feedback, and I will take actions for below points as well as the corresponding iproute2-net fixes.
> 	One more question is I see "uint" type is not valid during validation - see below (but which was suggested in v11), shall I change it back to u32/u8?
>
> Failed validating 'enum' in schema['properties']['definitions']['items']['properties']['members']['items']['properties']['type']:
>     {'description': "The netlink attribute type. Members of type 'binary' "
>                     "or 'pad'\n"
>                     "must also have the 'len' property set.\n",
>      'enum': ['u8',
>               'u16',
>               'u32',
>               'u64',
>               's8',
>               's16',
>               's32',
>               's64',
>               'string',
>               'binary',
>               'pad']}
>
> On instance['definitions'][42]['members'][12]['type']:
>     'uint'	

The advice from Paolo was a bit misleading. It is correct for netlink
attributes which support variable size scalars, but not for struct
members which must be a fixed size.

So for tc-dualpi2-xstats, the member types must match the struct
tc_dualpi2_xstats types.

