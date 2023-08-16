Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0077DA4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbjHPGMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbjHPGMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 02:12:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8C2136;
        Tue, 15 Aug 2023 23:12:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-688142a392eso4880141b3a.3;
        Tue, 15 Aug 2023 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692166322; x=1692771122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JT/qdz6coe3+Nqz8uykYsRaDPnNNzG24A+eA1ibaac=;
        b=Jf0kZVcd0bF0fBcnP/KH/KOiuI2+k8keS0UycuI+6bX0uZFJ/JIf0/ZnCBuWDOK4md
         iB7xXanVeBUWGu+2e1sdEJ+kkxYe1AQ4o8g+d85W0Jyjv2x0vY/cqQvUU1KvQ/clfa/U
         DcN4fO/4G3I5quVVBzs1CCVVIk0rb31FMD/PCDwHcPKdP0mxSIVp5t68qQ+puxMX4/oe
         dqbS+BD+rpr1qi/8YVpq0n3/BOJIdJK8gIIkYzG9HX7bsL6m7QvDtbydFgc/BNh9S3d1
         Rs5bPnFO1m2qURCEJRWeHiXtAxpsmRNs3aGHmhGA93Lyv45HvD2Uqry++PBQMGKyppwC
         azOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166322; x=1692771122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JT/qdz6coe3+Nqz8uykYsRaDPnNNzG24A+eA1ibaac=;
        b=JCjhYeASTBln6AOWBiVpDPSpS65+6PEEu8ITiESMh1wKk3iqoZuD6pik0L3sZklyav
         iofVMqsy95Y/N1gctq5KStY+a/1CFNcOQ7FPqdNrecZhTQBGfoyyokOHj/UDt0yfwnj+
         uJILcYn8ufwvdjOOIGLLo1xiraI4JI04UyJKSYPU7UfnrqHJX/nQ3kZIItrkC1xSYkdQ
         441GDKdbq1nojR875h74x1MQsW+vDrp/FvIkO1+wb/MSJPUaygRiHwBPPHxgkqHhVmfY
         RoiNf/p4ZCjyNi5YLfZA/3ZlXwkqe/fOx9NtU5zJ91bH/M7uWXCftPugyH30SZG8GC1v
         8BGA==
X-Gm-Message-State: AOJu0YxwA5nGozVNrSP6i7jmas91lXpleCZgopWS86XtI90uwGZvt1bS
        fsjzIeMG0JhODoTGEeMuKvE=
X-Google-Smtp-Source: AGHT+IH1pSV82dsyvCbIxY4PYlN5q9EU6/n72X1lt02aHs5BQt1RKOMU1BR22agnVwEc4VMCAYAwNg==
X-Received: by 2002:a05:6a00:3194:b0:688:802a:e429 with SMTP id bj20-20020a056a00319400b00688802ae429mr1001489pfb.23.1692166321632;
        Tue, 15 Aug 2023 23:12:01 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h27-20020a63385b000000b005641fadb844sm11152218pgn.49.2023.08.15.23.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:12:00 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:11:56 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete
 action of device link1_1
Message-ID: <ZNxorHjkyjktoj9m@Laptop-X1>
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812084036.1834188-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 12, 2023 at 04:40:36PM +0800, Zhengchao Shao wrote:
> When run command "ip netns delete client", device link1_1 has been
> deleted. So, it is no need to delete link1_1 again. Remove it.

What if the test exit because the cmd execute failed before setting
link1_1 to netns client?

Thanks
Hangbin
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> index 71c00bfafbc9..7b2d421f09cf 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> @@ -11,7 +11,6 @@ finish()
>  {
>  	ip netns delete server || true
>  	ip netns delete client || true
> -	ip link del link1_1 || true
>  }
>  
>  trap finish EXIT
> -- 
> 2.34.1
> 
