Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43417850EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2019 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfHGQUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Aug 2019 12:20:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbfHGQUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Aug 2019 12:20:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so627646wmj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2019 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nji/MJab6c8XNl8RhYUIOv/8j0dS1rMCymvSXokPK7k=;
        b=PCgGPS1NwN7GcFkgdS+Icr4J4FequZCuNwUy5u2lBC8q8dUOoRowHSH9uXB4yZ+242
         Mp82ghW5VveqR7USu8GQ8i5IelVvX1RmV2VskaLrmdTpkgz2MiA/EhBTgFfl0rnZgZDP
         +ESsC8jwma8qjhcVgjF+bHbVVfu7uqTrDP4788yVAtFsjk2zJ2VEdzgBx5s7YDPK/Bs9
         j2gaubkZiI+gynpk/R0R0HZSHz73ztaWbj1O5SHWLs/MnKezhse/tS0LNWhfGCKQgTul
         hvOrjv8xeNDSC5EdpCQlmeWXBscSxqKz/+Q8ZWY7ux/CL70tm1532hdojNbTfPqIiO0/
         AICQ==
X-Gm-Message-State: APjAAAUSjWvMkGwa5GqBBhB8ZPxLoPLvp/L8nxRjIn6I4A34OWQvcs9+
        /ZN3PYRxqW9LDpBYvy14ZJebRw==
X-Google-Smtp-Source: APXvYqwxFOco66AbUs2Ulj8/mmxE2NSuK4Th8W7hmqh9AUm7GMYwaF/+/oJXMfpkkte3AFZq90xkbQ==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr685267wmb.103.1565194803131;
        Wed, 07 Aug 2019 09:20:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b2sm127335289wrp.72.2019.08.07.09.20.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:20:02 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     shuah <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190807135814.12906-1-naresh.kamboju@linaro.org>
 <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <769e7d1c-c3d4-278a-d623-3a1366065fb6@redhat.com>
Date:   Wed, 7 Aug 2019 18:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/08/19 17:52, shuah wrote:
> 
> 
> On 8/7/19 7:58 AM, Naresh Kamboju wrote:
>> selftests kvm test cases need pre-required kernel configs for the test
>> to get pass.
>>
> 
> Can you elaborate and add more information on which tests fail without
> these configs. I am all for adding configs, however I would like to
> see more information explaining which tests don't pass without this
> change.

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

Paolo
