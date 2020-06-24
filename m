Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27717206C49
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbgFXGVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 02:21:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388090AbgFXGVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 02:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592979709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C48Rlxjz3s2bpLiAzhYiEAvH82Yp8YGVubELaSeN8Pg=;
        b=D57slq0md1urcbAEf2dHF65v2jLA3vGIEETbLLs6QSb3t2cQ2IcZ/IjUN3jLeGvjSQ4bcp
        u61x+KWLT47v3prarw8OWmiFIojK/0u+HEbi0ybZHHOQ9HD5qwt6nKiUJEO90IlhQkAqno
        Y7FLN5A1ojcA9a6ORXzBF9FYgBFzKDU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-btjIcFSeMii34WNrTCOVCw-1; Wed, 24 Jun 2020 02:21:44 -0400
X-MC-Unique: btjIcFSeMii34WNrTCOVCw-1
Received: by mail-wm1-f72.google.com with SMTP id t18so1867325wmj.5
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 23:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C48Rlxjz3s2bpLiAzhYiEAvH82Yp8YGVubELaSeN8Pg=;
        b=bAlEcQnIvSkX+fqyreu1o0TBjZyvEGXzfPFNNjh4GHL3++O43vJgWWM/zZdfTA6Diw
         6jkhbliB9I9p01imCn303FB0RJxO2P8Fg4hzwcobFfUphZFEHoe8ieb8KZ3TLKeTmYFL
         Gf/lH+wnUiwhcsAc/igNj63i0eiwnoijrC53b6zN4BnXv+QcWvdUjxFUOb7jEAz9FpiV
         HWaCYMMz2YJOelgmhAiJ+tLV787mRDIyNsT72S+1BOnibaq2sXjtmKScw9/f46jYPRK0
         fRev/uOlmvQqdq0cE54b5rXhoc/i/YnBrIs7E9dKSykx7Mew+ev5TtI68QkOVVFsh5wm
         zPNQ==
X-Gm-Message-State: AOAM530Y9duJj9FpgJ7BHl8HeDDxTEzME8omzMDBzwB8f1qjgol7J9sb
        YkdeWexjgNgixgK4hUqao5rnWBO5QbUoC+WX1Sy6Et1ei1IAAyHlRZzZ0N0Iftj1wlhd8ahpMlR
        X72cl/RRwO0t0RbyNXCWWHWJ+70yY
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr15268698wmi.98.1592979703740;
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRAU2gwlNqxDRRrpybYnMbwiytF23tZXMxgIgM8yxFkpT3cgJWPq+jOHz3hg3ByDv4mtlB/Q==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr15268688wmi.98.1592979703545;
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id t4sm400429wmf.4.2020.06.23.23.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
 <20200623204441.phngiwlj2idonpe6@wittgenstein>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
Date:   Wed, 24 Jun 2020 08:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623204441.phngiwlj2idonpe6@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/06/20 22:44, Christian Brauner wrote:
>>  	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>>  	if (ret < 0) {
>> -		if (errno == ENOSYS)
>> -			ksft_exit_skip(
>> +		if (errno == ENOSYS) {
>> +			ksft_test_result_skip(
>>  				"%s test: pidfd_send_signal() syscall not supported\n",
>>  				test_name);
> If pidfd_send_signal() is not supported, you're falling through and then
> you're reporting:
> 
> ok 5 # SKIP pidfd_send_signal check for support test: pidfd_send_signal() syscall not supported
> ok 6 pidfd_send_signal check for support test: pidfd_send_signal() syscall is supported. Tests can be executed

You're right, this needs a "return".

Paolo

