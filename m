Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78363D1F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiK3JcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 04:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiK3Jbk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23A654C7;
        Wed, 30 Nov 2022 01:31:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqn2hJ6z4xN3;
        Wed, 30 Nov 2022 20:31:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, shuah@kernel.org
Cc:     npiggin@gmail.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu
In-Reply-To: <20221029094643.5595-1-dengshaomin@cdjrlc.com>
References: <20221029094643.5595-1-dengshaomin@cdjrlc.com>
Subject: Re: [PATCH] selftests/powerpc: Remove repeated word in comments
Message-Id: <166980025336.3017288.12475821517637584733.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:13 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 29 Oct 2022 05:46:43 -0400, Shaomin Deng wrote:
> Remove the repeated word "not" in comments.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc: Remove repeated word in comments
      https://git.kernel.org/powerpc/c/ad8284ead833379fc57d90e50dbae1352b116c2b

cheers
