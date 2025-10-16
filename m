Return-Path: <linux-kselftest+bounces-43326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2FDBE3B1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C51A65AEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8A31AF00;
	Thu, 16 Oct 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ONFSU7e9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABE5FDA7
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621105; cv=none; b=Hv8EUdKzxYjxtpyJ5wFL8v0olVWw+T+PHwdiiavfIHTdjX6kSBLcvk3VhLc+40hgzO8PXCRkAbnpBabvp6/PAMiO7MqEO96u1BZxdj+NZJbfeprbCRCNt8BDpsI9RrzQ73p2mbqwYJ3VlUerPW6GmST3jpYpuSfvANoy0au1U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621105; c=relaxed/simple;
	bh=VruJw1T7uhapGa0jtAj1x3LRy8FHdBE1j78JBq4QfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXWaqK0KriVRlqoXFKCykuzyhRtex4/C9kZcuv6/Ph8EXj3L1mH8iaCmVQ/Bol1lpn16SsSZnte5y6YGwC2NhoAX/b2w6pdxlD4NjxMyWHakuX8ZC8dA8UlURvkNhvWZylSr6Eo+ixtiGcxx2gdM4rGUhig88TYvogy0NDQCLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ONFSU7e9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e47cca387so9288195e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760621102; x=1761225902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=ONFSU7e9ZfkjbcBQQekg+7RJxFGCkdpe0suu2cT/r1wbfVPBbPpS3S1xHOdJXBC0WJ
         T9aw9iliMWS6bT47IHV7DKU8DcfJX+ajRIcAjgLpkpUUmcOIpVdxVtjnJyxkuErkRfkL
         T6kUOnNtuQVl6zuLuKFA13te1Em0kJtXQ0lQoHCj+wVosl42Ke96kmdkPm7vA1CwLyCe
         6YeAsJEkgk4vcFk/ASg3xngRHoLJIhh9EVYDsM2lErx1iWGkg9CN2ZYuaAIbq/poM3Z3
         vz6zDnFSxqu33aLoRbs5Lzpnb+vvI5aOK5ocKH4iVJ9ac/w6meHkZZ2W59FzhHblUOuO
         6HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621102; x=1761225902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=pZB8PXSq+iDUy4/hpkMjpzGrx7tHoKMEj27C/1GCm/M3rtfQUJtKPpgHF1J2ykpjMJ
         a8bTbsC6ZDPzdEvmQgOu38f/dl4mNzii1zWA55Y2+l+VZwuFGXKgTHYBkMM5p+we5Jnl
         aJzjE3B2EMIRLX5DOEbkYOqbDrrBWN8IbzmCZrdvwg+2umvXTF3FaN1bdCLv6dkyNR7h
         H8+V/IwYsFaw+LVMjHMuWgGS5Wcw90CiGVbRWrVj9AdA/PaYvqr2jqye5Zgv62+u7+RN
         vDqxbqennjsfGobvTQR0la37hh+otk3PiLu1ZEBMhRoEzyD2Bv2TCd61NUoL52py+KyJ
         3Tng==
X-Forwarded-Encrypted: i=1; AJvYcCXo2W/wBUPKphOzaqgkbIzFi6GhMr/hItop3f2sjSB0/rJGmQ+oq04dvPzNRWpELuJYfENHMLHfzNQA6USNOkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHr1ra6GBrYKVOk70dOq/FfNMRzATg34MHRLdIY1P0IE5YFinE
	C4Fnrfnc7xALuQzhI1BTcGea1ebuWRbHHdTCl8LaviGc/LVmEjwJY54+xGwBjKpofeE=
X-Gm-Gg: ASbGncvkEyu8hMiRDmIwu+jnnYL3Be4BjZdEfCtqp0joACuYSqFe2fDywgvCR0zJKh+
	1SuyuknkJeapRAwZvsO2Rm0ewKnt+iytuXp0tyhT/zQ+ceOMFTcNe7KIaPo95b6ph/fHWJz8smu
	2oSAQ5nkH7VfdgIOzj7ZFM9aDcZ3x27zCCBr+4MJjkdhNBYaXl9to+OEIIkPvJfDXp4HbtstSl6
	M6xl0pKkxcB609lqfis1cvXV2QtB48ZLxCrI0BFhnSBbwvz8ve6H2jci6RyewPqR0HqSosSRCIV
	erPeZycewr31PSz0UOXcRdiOPHPbTfs5TQe1eofPmhiTO+ucjcqms3ZkgdHkDYZIWdTd8LnHYH5
	Nyu4x+YKrlfj4mvnX51qBmzYUPGrZSMmYFRZlH0kOqFfcNE8tHK5xXncIHYJ5+OtayFHeOv1zPG
	NI7pac1Sk33CvQN+4/N7SMZVO60/A=
X-Google-Smtp-Source: AGHT+IHylLhegH8EBHKyKNx8tuKkwCcVBihVX2MrfVK0KP+2FLw+1osRi3z/tz/c09s6arjEO2JRUQ==
X-Received: by 2002:a5d:64e4:0:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-42704d900edmr77046f8f.26.1760621101900;
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm42268005e9.3.2025.10.16.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:24:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
 <aPDnN072argrq23q@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDnN072argrq23q@fedora>

Thu, Oct 16, 2025 at 02:38:15PM +0200, liuhangbin@gmail.com wrote:
>On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
>> >> How about "master_upper"? This is already widely used to refer to
>> >> bond/team/bridge/other master soft devices.
>> >> 
>> >> MASTER_UPPER_DEV_VLAN_FEATURES?
>> >
>> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
>> 
>> Why? We have "master_upper" to point exactly at this kind of device.
>
>I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

If you don't want to use that, change the existing code. But when the
existing code uses that, new code should be consistent with it.


>
>I will update the name if there is a next version.
>
>Thanks
>Hangbin

