Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B021479E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgAXI6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 03:58:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727520AbgAXI6d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 03:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579856312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWz6aqGdHx35tZOwvGlucXWByVJJ94BypUpYqdf0YTw=;
        b=duDiNRBf3n8ySGaO3KOap+FBRXDv8N2Y1/Bmg+ZIjjaHeAYseb04wVvjv0YVbj2f6YO2QW
        AA0vOefuRcopssDx6pVYuYHnLU8haOyxzgt9vE1sIhXXWlnO/8swux29JiDoJ213o1IlSs
        oWaFJK0ShqrA6XXPOoSwMQh+eZ6My4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-kU9GfcKzNgG-yPrA7P8D8w-1; Fri, 24 Jan 2020 03:58:30 -0500
X-MC-Unique: kU9GfcKzNgG-yPrA7P8D8w-1
Received: by mail-wr1-f69.google.com with SMTP id 90so846229wrq.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 00:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JWz6aqGdHx35tZOwvGlucXWByVJJ94BypUpYqdf0YTw=;
        b=CqRZTVxL8H9TgP/9M9LSIbagQxc7XbGHLSjiQY8ZTuhBoWKfgToBHW1Y9ByiSzybjo
         2MKylqm1XiU4UGh7R7TOgCjk0Bbj5bGnoEBrgsAur58PE9/9CtIkl6KgW2dgP3sqiv5G
         9Ufkv8gdJN9EzHCYv8y1mPX1l9aBAJjmthA6yxKlkQ/uypfNoRBj4zUo3mDuNuBQr/fW
         AN6IY6cKDep+C9gW4xWI1ULhTQtgbd8XyNEhqYzq+9tIL92nbCB3OUt8ofR1CfJcoWHJ
         nI22fn77KLoLrXn8wi+H0JK3Acmjn2vqDbNh8yV/tTHHKqRH84zv+5tEUzjJzG++oDy3
         p4tw==
X-Gm-Message-State: APjAAAV+qhgXW9uQ+HD8ZDPmB0LYkWeHbifv2fjnY1nbYWcviIvMDbNv
        7xe8v52sxd5KutTPHLczMd4Iy5p6VUHLotk1nAJQYgIbrwWDjmY/NdlHDSo/X6tOj9F241gblue
        iU0BQw9dpJoI/ApXBvsogMQxESM37
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr2280689wml.55.1579856309503;
        Fri, 24 Jan 2020 00:58:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTG/Fx0cb6GxNxRaHqdTQSp/V/QSRYrq3Q3gtSptcEB3HrPrpH3UPGtIS+5Ympfmx+cp9+QA==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr2280663wml.55.1579856309137;
        Fri, 24 Jan 2020 00:58:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id c5sm6219331wmb.9.2020.01.24.00.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 00:58:28 -0800 (PST)
Subject: Re: [PATCH v4 09/10] KVM: selftests: Stop memslot creation in KVM
 internal memslot region
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-10-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92042648-e43a-d996-dc38-aded106b976b@redhat.com>
Date:   Fri, 24 Jan 2020 09:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-10-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/20 19:04, Ben Gardon wrote:
> KVM creates internal memslots covering the region between 3G and 4G in
> the guest physical address space, when the first vCPU is created.
> Mapping this region before creation of the first vCPU causes vCPU
> creation to fail. Prohibit tests from creating such a memslot and fail
> with a helpful warning when they try to.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---

The internal memslots are much higher than this (0xfffbc000 and
0xfee00000).  I'm changing the patch to block 0xfe0000000 and above,
otherwise it breaks vmx_dirty_log_test.

Paolo

