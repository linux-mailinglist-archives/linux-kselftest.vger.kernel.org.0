Return-Path: <linux-kselftest+bounces-6874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D22891F62
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A9B1F30D1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC21A154C14;
	Fri, 29 Mar 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je4jNSGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9D1422D9;
	Fri, 29 Mar 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718556; cv=none; b=sKqaHgW14G2b4KNi1KWfYsUX/dFHCUp+b0UUxm/rviwzZ18/rtW3B8T8lswKbwIu39URy6ulE4DchDcCBS1XEQuZDU2EIkE/qFAK2ri50YT4WPAo6QkiZ93bjWj7Lgo3vmVNU6oEWKAlBZh/8C0fUCTJzes/dTGoRVu3lbmQCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718556; c=relaxed/simple;
	bh=AnvJ5kofMrFFJqZi34ryz5OBe6mw7RXfXxGMEtAbKAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tg7Jji0Hz8e5mk/1KIDs+52CWUlV010jRKPhA9HC9sfo1eH1VYgOyXmyR6bRMpGkXExBFFFQLfwDcSY3kxQZx6EPf5qf7HWkblmq84PRUj450YlNucdWsTlrdR9vyZBrNqu1aYDVYsLzIUxwpIpyL9DGMASqS21RVL+MQ+WS9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je4jNSGa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415446af364so9121465e9.0;
        Fri, 29 Mar 2024 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711718553; x=1712323353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7xEQIH74hDY+Lda40i905LEC8Iht3ogaURW2kap73s=;
        b=Je4jNSGaJtYIX22uI04dL/yhpsXkEPu/CP6RrpVIfw5ru1l6gvPoxvyiDTMUG7Aj/a
         lP9S10cCk8TkTAtvd2TQxOjX9R95T7YsnRcbnRrbZvKBwrvnLetP2MA6dvlvpvMGH7Pv
         +XbioBaYnIO0LYhKz4s76/23mXpbTDU1hef+cegeXC8S2NDWNdRmj/viJ1gcmNQPa86w
         zs+1OARs3T/MV9sTSeaYVPrm5DFZw/RgRvN7iR3EYhFBzGD5iYqOgNQo7SXNtbZwFe3R
         rpGB04gBDJaG8RAJ+SEnoGYuWGPZARimWB5NctgnCTDv7GOy2u/AjSdiMXy+MAlkl7ih
         j0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718553; x=1712323353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7xEQIH74hDY+Lda40i905LEC8Iht3ogaURW2kap73s=;
        b=R3Lze86XldhwJl9PgYeh98NuhSsNaQH7PtlASkbQWWlL+I5RGYuPddmp0cvF+a2CaN
         g1CR+fvvERh2Mv7aeZOsJisRLhUZQqGt7mwiwzKh1uVS1K7P92ph/gM4uG9tgJRfIxE6
         c5+KGBvRi/v4xEQLM/wu5qKeAxpxnJTnxdl6qRw65uBdu3F3IMeZx99RrK21jJYjnf+d
         9sDwaegZG94O1G8XN8Z9WvgoAt/fMmINmQEFmntgKfgtMg+DNFwmZp0RwMWbVqKB8f5A
         WDBKYC7jbuoR55+zooXpqv7kDu8Je7AcD8mS/wElRYbWdAq5WQTut4P8T05115fGvP4g
         9RxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMoHOyjXWLv8LFyite9Ptqvjj9i5T3sJBK4S/c2l+tsk/iALVsLrBN6BK/xcoifBNEueynO69WQDEWRLV4EeQLmzsx9VPLF41w/qnDw7sQFfo203HmUc/v5KsRLsIirViFijANjUORNt9L0iWqXULY1Vc3KziqRLvLettV8aC6IhE+qkdsvAS72KVSkHT9VjdPcxC7ln+z9GVFw==
X-Gm-Message-State: AOJu0YyP5EpejNdmWNLnK9aEPdNwTIIy7oltT0NwiriZON6y1G6NY0+R
	dd+5GniO0j3FYmW+sCaxQt34hh/zGTJUNFQ+mb2OP1qnxrFMU65c
X-Google-Smtp-Source: AGHT+IEQnvVhjcJMskx1plsjPX+2uuWCMni3mouaDGDO8Y6eWc7PNFBU4mWPxr+4JuiHYzv0f2n1wA==
X-Received: by 2002:a05:600c:3c99:b0:414:90ea:34ad with SMTP id bg25-20020a05600c3c9900b0041490ea34admr4775141wmb.6.1711718552890;
        Fri, 29 Mar 2024 06:22:32 -0700 (PDT)
Received: from [192.168.1.113] ([105.107.228.62])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b0041550a2ac10sm1499996wmr.6.2024.03.29.06.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 06:22:32 -0700 (PDT)
Message-ID: <bcb084ae-c934-4eba-aadd-95bbec2a63cb@gmail.com>
Date: Fri, 29 Mar 2024 14:22:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com> <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
 <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <ZgXallkHApJC-adM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun, Alexei,

On 3/28/24 22:01, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 28, 2024 at 01:45:56PM -0700, Alexei Starovoitov wrote:
>> On Thu, Mar 28, 2024 at 1:02 PM Tejun Heo <tj@kernel.org> wrote:
>>>
>>> There's also cgroup.kill which would be useful for similar use cases. We can
>>> add interface for both but idk. Let's say we have something like the
>>> following (pardon the bad naming):
>>>

Yes having the cgroup.kill from bpf would be useful!


>>>   bpf_cgroup_knob_write(struct cgroup *cgrp, char *filename, char *buf)
>>>
>>> Would that work? I'm not necessarily in love with the idea or against adding
>>> separate helpers but the duplication still bothers me a bit.
>>
>> I liked it.
>> So filename will be one of cgroup_base_files[].name ?
>> We probably don't want psi or cgroup1_base_files in there.
> 
> Would it matter? If the user has root perm, they can do whatever with the
> files anyway, so I'm not sure why we'd restrict any specific knob. Maybe we
> wanna make sure @filename doesn't include '/'? Or is it that you don't want
> to go through the usual file name look up?

It would be easy at least for me if I just start with cgroupv2 and
ensure that it has same available filenames as if we go through kernfs.
Not a root cgroup node and maybe only freeze and kill for now that are
part of cgroup_base_files.

So if I get it right, somehow like what I did but we endup with:

In bpf, cgroup was already acquired.

bpf_cgroup_knob_write(cgroup, "freeze", buf)
|_ parse params -> lock cgroup_mutex -> cgroup_freeze() -> unlock


cgroup_freeze_write(struct kernfs_open_file *of, char *buf,...)
|_ parse params -> cgroup_ref++ -> krnfs_active_ref--  ->
     -> lock cgroup_mutex -> cgroup_freeze() -> unlock + krnfs++ ...

Please let me know if I missed something.

Thanks!


