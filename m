Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC41F3E85
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgFIOp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 10:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55197 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728993AbgFIOp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 10:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591713926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=KiW+sUf40IGeFLP0CBk6z6ojC2g+Q6URZBahsgm6rI4TyUxGfVTFCvJsQcVIcAk92gMXA9
        rHhvp5gIWj99A3BV0bwX+m1ynD85K8jZhYKTAgTPMdeqpe63goTMqyIiPDfF5LJ7ITyldw
        7Z9a3pMiC0wSkzZlYToT/vkRtEDdAAs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-02goOJxOMrazXOPRTqjYkw-1; Tue, 09 Jun 2020 10:45:23 -0400
X-MC-Unique: 02goOJxOMrazXOPRTqjYkw-1
Received: by mail-qt1-f199.google.com with SMTP id y7so18591596qti.8
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 07:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=sokZIEbtcfIoWOg2679ZaMRVa2ljJ8YPYTXcO7qc2EJ5sRrtvC1rGL5k+fABSfd8HT
         /sQevRp0wPOP1JZCZPFSy66QrUUrqokHUj/1HBw9aa2t09qvU634dy6BJ8kOYJezQjDN
         qeX1N6c/atL2l8EjSV6enJTLC1tCcknAN7YcPvVMVlX1fO4F+KfW8nlVDVdB7hmo2iv3
         qyxUdUMAEXtd+gKjwm7xHbOwDwwdc8+c75wyYnMpQs59F+FZ5Sg+jqXmtVG1LTNw33Lo
         6pqh5Vuo1Lb3t57kSilT1Z5NZwIvOsfHVdpI7HfumkkYzSw7sZ9e3YWTGpiS3kh4tMUp
         0SJQ==
X-Gm-Message-State: AOAM5327gY+oRl9lJDTW4RTBjI3vEkf5f9foqHDB8L7lekOda9agGeAP
        7trgnYoyb3ovHViV3iKRyVuqS7gqNMcdDUcs+nApMbaXeL3gyczAe2vzdhta/tpjZGKkAH8Y0gH
        jkIoAXQnoBKSevGhdFD5BvYOBNGpO
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146850qkc.397.1591713921614;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrDWGGcedgDp0WJSfkST6HxfilfGNNkZ2qb1/AuAvSqBZwRXvtCKZT5td9mD5UlkwPlyTrdg==
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146798qkc.397.1591713921109;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f43sm11650042qte.58.2020.06.09.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:45:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Date:   Tue, 9 Jun 2020 07:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200609142007.GA831428@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Why not use the ksft_* functions and frameworks to properly print out
> the test status and results so that tools can correctly parse it?
>
> It's generally bad-form to make up your own format.

I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?

T

> thanks,
>
> gre gk-h
>

