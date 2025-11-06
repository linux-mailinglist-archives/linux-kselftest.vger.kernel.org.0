Return-Path: <linux-kselftest+bounces-45030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24112C3D968
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 23:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFC31890357
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD7329396;
	Thu,  6 Nov 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJLY+pre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5A32143E
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467943; cv=none; b=fPQaNkw/+dtmSrVApp6IRG07Arq7Y4wE4QFGpy0fR7dqJ3djEh9jGV6U9Iwul9hfdumymR9WViTAM6kbndSKky02C+y94oospUUHcJ5gCby2f8wht+uFxMpCCBydkV5Q9mfS2hTDhDxnFvkBsNXDXtoJlVgsVjEZ56xB2/Q/P/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467943; c=relaxed/simple;
	bh=c3Lbyug0B8LC1SBsLJoiXKtGPHiW/sjp9Vcgo1geYE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkdvzfG/lbwLkmPL4GriR2GOMzv11ryVBc5toXskrsOye1mOjIYh4bDMJ44LxtCF6CjC2wFS92jwF3mBmLR9ukuiywDAA736gG4FemjFlBuwOy8+jl5wgbSKTu1IrEdUxEXWk1gr1uCtU+Es0Q6KeW1o1sAGV37wWiTqA8IXhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJLY+pre; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9486b567c18so5758139f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762467940; x=1763072740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=cJLY+preBPJZGlZ3bZLeWjLc3o+HaU47ziG3X/uFLhgBj5kWfPQ5mnUz+Lhfv6xlXt
         YSwSPoHW0q+h21J0GQ5vJKj2GMcOZajq8Vh9+p54Z1v7G+urMj6SXnlXdRmAMY9RUpSP
         8r0LG8SO2rtl06djLxZwPqibigGRqk+Jqi7jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467941; x=1763072741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=ULn7I6XWEkOGTt51qAS4/z5JYgGw3wPDmG3590amqZPP56tdeIqriUd+/4d4HqxWU7
         lu7qpyx4CWlVqAjvyc7TlFLmlM6xHJYuyW5bhkCpN1MsLewNjC56YPcND8gM+aGDHXQd
         dnGX8T3DjTWFJIhHGF+Wsb+1surA7kaRAmpr7EdBHO9rs/BmRQjPFptPiHl6kkkSML0h
         X0iDKQ9Zu9YSf6oR5l0DKkefdbVRwVafk0qgs+ilr3XDBUDJvdjYBfsZVrXiOOvtVBRe
         fEByDJzkI9eO1mSRTPmYWNYdgANu7+CojqFgHPtohJ9Ru0PMF3GE9+DoIVMzySFzILEA
         aRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrnWo27OYAfyFHE7WF0pBgJHcDrZChKmnFqOTVm6+JwsdQPhtTDE+XltrGfmgyttGy1i6lkwh81OqloLzl9z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSi8NDOTJJcdPSbIk/xS0IsDe+r2YcWdo5oGYkZE2BwhMZgskM
	zFKiQGMlo5gywaTnf9U5Hpn5rdU56xumxnS8bvh3ZXec3WLIZX7m1wf10PlTrWkN7C4=
X-Gm-Gg: ASbGncuz7JvNQP/676G/ZuXOQYhMmLa5L/d3hZAMIq3EbOnqifwWlHuLJSb/fr4yDCX
	ZBzgYbzIcdb7I5tv4yEPr+MRofxSEQwEu7Iv5IoISIO50f2bN6dhXFnVM1inaAzg7JTZNxaSE7P
	a1tmyiEK72R4ISTWVWRh2aKDDPTIczxcZSHrzWKOkaHNXzIWH/qIBqI97xprkNc8KX33Xy+HBg/
	i8tzJrf6Ox2zYL8Tv8c37zlOTqr6yiyTj5sl6X8lICftvA5fzLt/TGpuZQjhon6C4qZZ0l8eG81
	5mBSMwDwVWJZJHmle3VszT94/4AqSSSyreyRCG71NDKALbnxupckFY7rSQj3nTlSU35C2OB3kMv
	x0dlxrvJYIdh0JkFtl/xcUyMK+W+F+nvlJ5MO9fu1HNSAwGqnUmSir6wipoUojWQ+pCMeYD4JB4
	N2lUGNF8vKYTRa
X-Google-Smtp-Source: AGHT+IH0/3GJ4ianQvzZFggnE+5AVLuBjfhvBYg0/6brP9mgyD+T6dTbpZArnCJ/fgMPmOmGaPjq4Q==
X-Received: by 2002:a05:6602:13ce:b0:945:aa01:bab7 with SMTP id ca18e2360f4ac-9488870ec4emr224804139f.5.1762467940613;
        Thu, 06 Nov 2025 14:25:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948889fae8dsm32195239f.0.2025.11.06.14.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:25:39 -0800 (PST)
Message-ID: <0abf9a34-232b-4840-b592-672aa277509f@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251014145149.3e3c1033@gandalf.local.home>
 <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 16:47, Masami Hiramatsu (Google) wrote:
> On Tue, 14 Oct 2025 14:51:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
>> user space") made an update that fixed both trace_marker and
>> trace_marker_raw. But the small difference made to trace_marker_raw had a
>> blatant bug in it that any basic testing would have uncovered.
>> Unfortunately, the self tests have tests for trace_marker but nothing for
>> trace_marker_raw which allowed the bug to get upstream.
>>
>> Add basic selftests to test trace_marker_raw so that this doesn't happen
>> again.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks. Applied to ksleftest next for 6.19-rc1.

thanks,
-- Shuah

