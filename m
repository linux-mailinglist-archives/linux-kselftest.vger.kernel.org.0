Return-Path: <linux-kselftest+bounces-6213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03745878573
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E131F218E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2054BD6;
	Mon, 11 Mar 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeQ1PhNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9A495CB;
	Mon, 11 Mar 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174420; cv=none; b=dIObtWsirlHGTkVVJ+2DFVzd5W3lnI2li8OG5kKH6Zftt8VjhR/26DZCnhUx8hpuaYzCH9y7pg+j+hyGU/sEu1Wq1LFk3vDg2TPQWIb2Qnzv2l8j8zxtrxi3XgBEnEjlkIoWoQkXTS6/lzWFkuJC9FM0Pc/dxVU5SxFZwWxxwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174420; c=relaxed/simple;
	bh=TcSwDHfNNgdR4wLojxjff0dRD10Inq481uYy2p6LuD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHluNOuFxUtYUBOmqS8U9Jq7YmzSbaaW429moY5f9LXUgF+EIco/IVh7UWrWcOZXCKuQglfOTMtCFRLu4HMhg1OsDeB/ZIrJqvCWWgg4ecT2g5Uvux+8JgI08Ve9Fs86nr905U8tTF+C0Un+4sf71HxEJjmVRVrBTJp6pRKqEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeQ1PhNo; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bc332d3a8cso221410139f.2;
        Mon, 11 Mar 2024 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710174418; x=1710779218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQKSOiWUfUqtlvjIi4/X3xeJgscUEIjq/1jiDqrAsaU=;
        b=HeQ1PhNow9FlBsQiUjxTXC6qjMRmYtrIAjDr06x8RlbbtrSaIBcl+s9C6/GQdK5DQO
         UTpVlQM7MdK+b5QMzaIOMNHOpFZ138Ek9EBGKILftSADyc26E59fGrveXd7W7xOd/k6M
         GFJ3yr53RRkde+B9dSwc2GITihEV+eFy1l695bmmg5qcZuMB5zq1ljQNLDevJ9isEmbn
         LUJ6u3Dil+bok1Xzxfaf+R760yRm0MjPLKq+gQ9lYEsOMYgK8/zXP/Kzbmk8opTxf8bv
         MdqOE1tdyl985OW8HRhPZlLA1vSOVd+gxEpmVncp6OdK79SMkvgGp9WWsfjUtDEOzJxw
         GFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174418; x=1710779218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQKSOiWUfUqtlvjIi4/X3xeJgscUEIjq/1jiDqrAsaU=;
        b=iy3UO2Q0TGFkJQ6KBMczZzj+FN88n4BHwpjE7AAeOKrOZE2TSndy+Pfn9lAaQknGtb
         xnD4FR2sp5Xp+tPNPpB5yf/kscY3TzoUKc3i01LRQhhM4gkmCcI23uL42xofldvrbH9T
         CmFMFD5QBpOo5dMIhSphILQvF0KlUOeh2h53L1YhpFs7nG9JxZSm3nbM3nngqwankksk
         Mz600humMSeGgWgFyWn2h/WCrrbH8+2MI7HIDdgU0/wTGmZYcUylYnzvVrFjz6JfUAQW
         kubVuoGXPC4Xo8i8TRmNoOqSCqFSqLIu2L6t06m0sxOJj5/3xl+sUH3d1+YmsueaWMAx
         E3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSNZ04fULcQoISqT9zKliJ19/swQUDg03qdCbykSVfX18VUHYtqoyjKXDeQJpxyK5Wkp/Nr4dQWhJLmGOn0YgZbbKfwDKICeo5815dNJdvPe+aryu8dUg0WrgiocZnQM3549rJLOCeCGEDh3/K
X-Gm-Message-State: AOJu0YwmYsN83gncJFkhhRMfWiVIqbb7UaEiClU3gR/EpSeFiaUEhs7E
	Jhi2UfEqJ5/nJcI/5DTI7RaCNxIsKEk6spmZaZLuiXh5pJ1xEW4S
X-Google-Smtp-Source: AGHT+IECo2iHOUjpdeONaUHjvq623/XyoyVPkWsq2s0ydvavN/sgfnJT26x5Rd1V8RdUQt5khihShw==
X-Received: by 2002:a5e:c10d:0:b0:7c8:c922:202b with SMTP id v13-20020a5ec10d000000b007c8c922202bmr754312iol.7.1710174417711;
        Mon, 11 Mar 2024 09:26:57 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:d7e:114:8305:f21a? ([2601:284:8200:b700:d7e:114:8305:f21a])
        by smtp.googlemail.com with ESMTPSA id u22-20020a05660229b600b007c8c539e1afsm297522ios.26.2024.03.11.09.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:26:57 -0700 (PDT)
Message-ID: <685a957d-5ce4-4165-aa6d-71570866b9d4@gmail.com>
Date: Mon, 11 Mar 2024 10:26:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG net-next] fcnal-test.sh: 4 (four) tests FAIL
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9f24a9c3-4813-4518-9cc4-3923c11981cd@alu.unizg.hr>
 <20240311091751.5c4f2947@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240311091751.5c4f2947@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 10:17 AM, Jakub Kicinski wrote:
> On Sat, 9 Mar 2024 19:45:15 +0100 Mirsad Todorovac wrote:
>> In the vanilla net-next tree build of v6.8-rc7-2348-g75c2946db360, with up-to-date
>> iproute2 built tools, fcnal-test.sh reports certain failures:
>>
>> --------------------------------------------------------------------------------------
>> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
>> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
>> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
>> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
>> --------------------------------------------------------------------------------------
> 
> Adding David A to CC.
> 
> It rings a bell. We also build ping from source when running the tests
> locally, I have in my notes "AWS iputils are buggy, use iputils.git"
> but unfortunately I didn't make a note which tests were failing without
> it. David might remember..

yes, please update ping -- make sure it has proper support for
SO_BINDTODEVICE.

It's a bug in versions of iputils ping. It sets the BINDTODEVICE and
then resets it because the source address is not set on the command line
(it should not be required - they are separate intents).

