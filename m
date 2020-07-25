Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4FA22D9D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jul 2020 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGYUXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jul 2020 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGYUXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jul 2020 16:23:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5FC08C5C0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jul 2020 13:23:19 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a1so9361427edt.10
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jul 2020 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0Th57xgtfkchmcZxsB458zve0k9vknOwyUMP9v2Iqc=;
        b=FWKrZOV3H27CAjvjAJeDsyKQLA5xNfO3yYIziGjYBC73EPCiootSOYerRqnltG7Fm6
         7hJpcxxZN/xEVegMZtcFlhGL598qkPpSBtyawL5CNBgLgQy7+oZ1AxBnNN41OXwtnUAh
         h0JU/5HSVmkCNFmgzAxRJ+P9AsJ+79WWGW92I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0Th57xgtfkchmcZxsB458zve0k9vknOwyUMP9v2Iqc=;
        b=QsDdylsmQjeLXAfjTxlZnRBhbrTpaxmlf+E8e7r7LT/HucFnDl4nuIm354coHNP93Y
         5liHmQY05+IpZF3T+qEGRodIeDxTIDk8t2A9otJvxp3l6DaR3durfO9ynimKMRXo3vRo
         lKr7EYxdxti9KZ2x8lCEGrQhd92P77CepH0cG+eJRO1k5oEmNnwS/88HwEX0BGA9gy5+
         pJ0yDAz78vWYSDCZTnu3uvvlPLJtHGPMAn6J0t5rgi9fPOGBwKb15s61AvXmiE8LZGgr
         hBTMZtQh+y2FTWS8NExw2fSfOtM4jabHW6C4WfxX+a7v9nIh/hfgXvoFBrQewmDBVAmC
         +mTA==
X-Gm-Message-State: AOAM531/1G1h5pQr1AG2tSOYNzj9XCKexr/zrTTnHy35xvmgawND58Ic
        8w1gf+x+OY2cw1badRPrq31siw==
X-Google-Smtp-Source: ABdhPJw/VbbF6tHZ8NOmdYEdOvt/UrR9OBrgYqtAuEXX/5/ArYD5dIF/TN1Y/MIoqFdV7ZJCRvMYRA==
X-Received: by 2002:a50:cf43:: with SMTP id d3mr15290801edk.40.1595708597833;
        Sat, 25 Jul 2020 13:23:17 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5be3])
        by smtp.gmail.com with ESMTPSA id rs5sm3399321ejb.44.2020.07.25.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 13:23:17 -0700 (PDT)
Date:   Sat, 25 Jul 2020 21:23:16 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [cgroup/testing] cg_read_strcmp: Fix null pointer
 dereference
Message-ID: <20200725202316.GA349701@chrisdown.name>
References: <20200725181506.20199-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200725181506.20199-1-gaurav1086@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Gaurav Singh writes:
>Passing NULL in strcmp will cause a segmentation fault.
>Fix this by returning -1 if expected is NULL pointer.

Did you actually encounter this while running the tests?
