Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3AF2DD871
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgLQSda (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgLQSda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:33:30 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A59C061794
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:32:49 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q1so26737566ilt.6
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euqBXwlKpksM2O1B20N3zwYJHM+krRb1R0QlrPJovKs=;
        b=hloE6vQ34Nt0jvI6wpY7VyipHe1zhzyr1SdISONaS2dIFdFEvi78131QKFFDzX4pKc
         NrO6qu4ndHfPR+rXUnD3mJbBbsvfgiNoLocM+ZCbE9Ij20m3Kn2GxT755xEKCgh1fvh6
         yU9lp7+wI8RWhYTb8mQH3oHnDFFN9h94b8WQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euqBXwlKpksM2O1B20N3zwYJHM+krRb1R0QlrPJovKs=;
        b=PmS+65eTg+ToqaIyszH9TB7F+WPZCBHmQluhf0JqyuMQkkxQMmN/5UQ/Qb8tw1+uc+
         l0uew0wyt8L2hHMLZ6HunlpFdCxuja9EXt0HS2ej2kOFTl82jr5hm/vnI7YLGAMgPDOe
         aN7MWlIymBQ5ILGLuJKSo9iWiCn6fJ5Kozbrfc3z96dfJ8MoXvlgfAsUH14FDAxhh9Kj
         XAyxEh7C9IkIhqjpOR6OeXUhm+iyM1rsgu1NlP3qdbk9Tv6eBI66iJ2T/Om5X182AStX
         LZ8bEBPI+h1qFBlNHerKpDQ57f7xKG3d0xZuicU8jBYw/7XK7DjPdMbUGvpY9uF3tokq
         7nLg==
X-Gm-Message-State: AOAM530meNX2TQOPb+SqkrR3FEiD5xz5GICqKooOgQOagLLMMpCtP7R4
        njPx1uCyjdZNeU6bZYTVxLFcGw==
X-Google-Smtp-Source: ABdhPJwKbvtaglTe9buBF6UPtZDTuxPohT7p6/IvZcZYmSMeL0UCG5btnwEfAEImPVuebSVaKl8DdQ==
X-Received: by 2002:a92:155b:: with SMTP id v88mr124823ilk.303.1608229968746;
        Thu, 17 Dec 2020 10:32:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d18sm3662791ilo.49.2020.12.17.10.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:32:48 -0800 (PST)
Subject: Re: [PATCH] selftests: Skip BPF seftests by default
To:     Mark Brown <broonie@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201210185233.28091-1-broonie@kernel.org>
 <X9qExiKXPVmk3BJI@ubuntu-x1> <20201217130735.GA4708@sirena.org.uk>
 <94010653-0cb3-d804-7410-a571480d6db2@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <008fb8b6-2632-e0c8-8e6a-c643d953bde5@linuxfoundation.org>
Date:   Thu, 17 Dec 2020 11:32:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <94010653-0cb3-d804-7410-a571480d6db2@linuxfoundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/20 8:53 AM, Shuah Khan wrote:
> On 12/17/20 6:07 AM, Mark Brown wrote:
>> On Wed, Dec 16, 2020 at 04:05:58PM -0600, Seth Forshee wrote:
>>> On Thu, Dec 10, 2020 at 06:52:33PM +0000, Mark Brown wrote:
>>
>>>> as part of the wider kselftest build by specifying SKIP_TARGETS,
>>>> including setting an empty SKIP_TARGETS to build everything.  They can
>>>> also continue to build the BPF selftests individually in cases where
>>>> they are specifically focused on BPF.
>>

Applied to linuxkselftest fixes for rc2

thanks,
-- Shuah
