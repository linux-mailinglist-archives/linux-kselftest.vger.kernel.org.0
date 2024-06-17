Return-Path: <linux-kselftest+bounces-12076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AB90B753
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC581F2343E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26716A94E;
	Mon, 17 Jun 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AicaM2oZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA51684BF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643803; cv=none; b=S5yKfigima/LPHMhENjygCGy/tnhonLdjf8WuyRRZeWGt1FTYgZr5Adqarw2YnuwghuxSnHmPYW/kVliJDylAeVwgdAx1MJf4zqEUM+UE1/NZTSl5oz0t2piAcZ4+nmszwB6Btf4Br3S8ifw019W3+iWrvH+N0B4iBOVW4EZfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643803; c=relaxed/simple;
	bh=bWPFLz7Uaa6wJzzPddCt3sTX9Kur78ZARf2yRpSV7WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiXOaHu4W1czp6c73pDAnwDwBBVi+6toy25SjfgYD2ZsDQxbKrplX6MKs1I/1E1bCLesFdYpaDXzpQU6MDZ3ijX+5foU+wIORoZOoFvjbm7xSeq6l13T0A1ShRgpghCZm6kzRr7NyrRysbUUfzP2KSbjLbrUFLbk+Q97FtwApq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AicaM2oZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718643801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JalWu6kYqo8R06ZJPIHopQY194QJtk5roxVnOqVNVxM=;
	b=AicaM2oZw7HUhTOEOErrOoNgRj3QgiEjl1iuLuQDsros/kKTP6pYb1hAQXyN08nvFzYkSG
	k/PNnAzm5XN7TsTe6KcQJkOHypwbl9OvIodNLrnnFN5grWQRUZrXWAeouI512DrPWeTxv8
	VkU0Nf7DiOdF1v1iV5yW1EROgyObalM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-zTZNbtLPMi2hajCtMfZQOA-1; Mon,
 17 Jun 2024 13:03:16 -0400
X-MC-Unique: zTZNbtLPMi2hajCtMfZQOA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9DDA19560BF;
	Mon, 17 Jun 2024 17:03:14 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F183000225;
	Mon, 17 Jun 2024 17:03:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  Ilya Maximets <i.maximets@ovn.org>,
  Stefano Brivio <sbrivio@redhat.com>,  Eric Dumazet <edumazet@google.com>,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  "David
 S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 1/7] selftests: openvswitch: Support
 explicit tunnel port creation.
In-Reply-To: <20240616162512.GI8447@kernel.org> (Simon Horman's message of
	"Sun, 16 Jun 2024 17:25:12 +0100")
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-2-aconole@redhat.com>
	<20240616162512.GI8447@kernel.org>
Date: Mon, 17 Jun 2024 13:03:09 -0400
Message-ID: <f7tr0cvmrhu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Simon Horman <horms@kernel.org> writes:

> On Thu, Jun 13, 2024 at 02:13:27PM -0400, Aaron Conole wrote:
>> The OVS module can operate in conjunction with various types of
>> tunnel ports.  These are created as either explicit tunnel vport
>> types, OR by creating a tunnel interface which acts as an anchor
>> for the lightweight tunnel support.
>> 
>> This patch adds the ability to add tunnel ports to an OVS
>> datapath for testing various scenarios with tunnel ports.  With
>> this addition, the vswitch "plumbing" will at least be able to
>> push packets around using the tunnel vports.  Future patches
>> will add support for setting required tunnel metadata for lwts
>> in the datapath.  The end goal will be to push packets via these
>> tunnels, and will be used in an upcoming commit for testing the
>> path MTU.
>> 
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>
> ...
>
>> @@ -1702,12 +1711,43 @@ class OvsVport(GenericNetlinkSocket):
>>          msg["dpifindex"] = dpindex
>>          port_type = OvsVport.str_to_type(ptype)
>>  
>> -        msg["attrs"].append(["OVS_VPORT_ATTR_TYPE", port_type])
>>          msg["attrs"].append(["OVS_VPORT_ATTR_NAME", vport_ifname])
>>          msg["attrs"].append(
>>              ["OVS_VPORT_ATTR_UPCALL_PID", [self.upcall_packet.epid]]
>>          )
>>  
>> +        TUNNEL_DEFAULTS = [("geneve", 6081),
>> +                           ("vxlan", 4798)]
>
> Hi Aaron,
>
> It is corrected as part of another patch in this series, but
> the correct port for vxlan is 4789 (i.e. 89 rather than 98).
>
> With that fixed, feel free to add:

Thanks Simon!  Done.

> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org>
>
> ..


