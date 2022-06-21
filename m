Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6783553496
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbiFUOd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbiFUOd4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 10:33:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3081C127;
        Tue, 21 Jun 2022 07:33:55 -0700 (PDT)
Received: from [192.168.10.5] (unknown [39.45.247.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B53416601688;
        Tue, 21 Jun 2022 15:33:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655822033;
        bh=F8yRvq3Kx4hHKAfFp6vxgPwTAuKL3kJxkpN/M5vr8DY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=h1Ddw65ku4x4Nz7IzNI9dXxbxgHEDS1oXPh3Ik5YWwcmtnFtu4gTAqD7vY98PONbS
         BKWE4iWsQy+CrobZHgfJS0S8iP0ZkoZQyGVpg/nQFxWJDPHGdM/Q1LzbuDe8r5EYOC
         7LrQEal5vlPjDHPALOP8MD3CbWTbnjqxCsJc5eGyniip8Z9L5U7Vru/hMGckRgrutw
         76xda5pWGluCK01Ot/QyJY9isqndWIe6RnnDjPPAOAU25if5ezkFAj93VCHDO1SmYg
         i/Wa6cu4xVqXQHngCI2x6RDZKRkzEU7b0dYaMHI3T+VcACjHwHer8vjiVjuXu4t9fp
         VK+g09nMzsFOQ==
Message-ID: <0e8ea624-3cf0-7c63-9b24-8c4109096d3d@collabora.com>
Date:   Tue, 21 Jun 2022 19:33:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        bagasdotme@gmail.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
 <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
 <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/22 2:41 AM, Shuah Khan wrote:
> 
> The change looks good to me. I am catching up on patch backlog after the
> merge window and vacation. I can take this through kselftest or if it
> goes through doc tree - here is my
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
This patch hasn't been accepted yet.

> thanks,
> -- Shuah

-- 
Muhammad Usama Anjum
