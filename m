Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B83740F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjF1LBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 07:01:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjF1LAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 07:00:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79DDD1F8C8;
        Wed, 28 Jun 2023 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687950053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEeHosu/oML9JDjU/7XZAM8AQ408Jykez/SpHOEovT8=;
        b=agQXzBpbnVJLktZC7JCZFQtqzlKy79joyuCWUkH0zzl6/Z5TtrYUpukAZ/CTlMxb7+jVv7
        nGfmKtBd17feebkJbXRPlKM7hWE4NfpK+4uODigJLQ5QGNseYjQoaeVZ4BXMq7NsUeffGm
        +Q5wjO1VpwSCuucApRn6KvxadKgaOMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687950053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEeHosu/oML9JDjU/7XZAM8AQ408Jykez/SpHOEovT8=;
        b=wpTY9CNRtF1erZ0YakqMDV3lFVdHotkFgZSs907rGua9E7nLZ/zqmm0jETGKVKFQRSFGyu
        Jw0Sh7iDOTRSNcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BC9C138E8;
        Wed, 28 Jun 2023 11:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rgQaEeUSnGQGLQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 28 Jun 2023 11:00:53 +0000
Date:   Wed, 28 Jun 2023 13:03:10 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Subject: Re: [PATCH] selftests/zram: avoid subshells and bc for ratio
 calculations
Message-ID: <20230628130310.416769d5@echidna.fritz.box>
In-Reply-To: <20230628105345.16952-1-ddiss@suse.de>
References: <20230628105345.16952-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One minor follow up...

On Wed, 28 Jun 2023 12:53:45 +0200, David Disseldorp wrote:

> Awk is already called for /sys/block/zram#/mm_stat parsing, so use it
> to also perform the floating point capacity vs consumption ratio
> calculations. The test output is unchanged.
> This allows bc to be dropped as a dependency for the zram selftests.

It looks as though the following hunk should also be squashed in. free
usage was dropped with d18da7ec3719559d6e74937266d0416e6c7e0b31:

--- a/tools/testing/selftests/zram/README
+++ b/tools/testing/selftests/zram/README
@@ -27,9 +27,7 @@ zram01.sh: creates general purpose ram disks with ext4 filesystems
 zram02.sh: creates block device for swap
 
 Commands required for testing:
- - bc
  - dd
- - free
  - awk
  - mkswap
  - swapon

