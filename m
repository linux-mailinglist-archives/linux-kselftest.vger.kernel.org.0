Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48D7D45AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJXCqJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 22:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjJXCqI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 22:46:08 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8283;
        Mon, 23 Oct 2023 19:46:01 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qv7QJ-0003Ej-0b;
        Mon, 23 Oct 2023 22:45:39 -0400
Message-ID: <c47d47c45176f0a703b7d7d4725078b607411c17.camel@surriel.com>
Subject: Re: [PATCH] selftests: add a sanity check for zswap
From:   Rik van Riel <riel@surriel.com>
To:     Nhat Pham <nphamcs@gmail.com>, shuah@kernel.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com, tj@kernel.org,
        lizefan.x@bytedance.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Mon, 23 Oct 2023 22:45:39 -0400
In-Reply-To: <20231020222009.2358953-1-nphamcs@gmail.com>
References: <20231020222009.2358953-1-nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-10-20 at 15:20 -0700, Nhat Pham wrote:
> 
> This test add a sanity check that ensure zswap storing works as
> intended.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> 

Acked-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
