Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D365FDE91
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJMQy2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJMQy2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 12:54:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D067042
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 09:54:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1696933B6A;
        Thu, 13 Oct 2022 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665680065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q49ixtbos9k+FZBLMo7Ms7yhm9TFWumzjq7BMLl42xY=;
        b=B6mhAFcKTN7PibeXpKwS2aFV4xAognjs8WQ7P7ADGUujK1j2REZFdLwLI4O6QkE8Jefa4j
        r0pniyc+HjakuvK90Pds6rxdOE0ONhRtdNg91+UwyxgnZZBrBxYYgL2kHu6X1aUSn59btQ
        Op0WACWnRi37x8i68yUK8GTRlR+7Ld8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665680065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q49ixtbos9k+FZBLMo7Ms7yhm9TFWumzjq7BMLl42xY=;
        b=FZGyXis2t3f0VMxDAfiWIMWGW3G4t/gR+Ch1MnPE0tWC3l2NvSYvpT3kwzi8BKak1WwYpC
        ezcfcztR2kJOaUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D5C139F3;
        Thu, 13 Oct 2022 16:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aL57L8BCSGMINgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Oct 2022 16:54:24 +0000
Message-ID: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
Date:   Thu, 13 Oct 2022 18:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: hmm_test issues with latest mainline
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I've been trying the hmm_tests as of today's commit:

a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)

and run into several issues that seemed worth reporting.

First, it seems the FIXTURE_TEARDOWN(hmm) in
tools/testing/selftests/vm/hmm-tests.c
using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
assertion failure. Dunno if it's a kselftests issue or it's a bug to
use asserts in teardown. I hacked it up like this locally to proceed:

--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
 {
 	int ret = close(self->fd);
 
+	if (ret != 0) {
+		fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
+		exit(1);
+	}
+
 	ASSERT_EQ(ret, 0);
 	self->fd = -1;
 }

Next, there are some tests that fail (and thus also trigger the issue above)

#  RUN           hmm.hmm_device_private.exclusive ...
# hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
close returned (-1) fd is (3)
# exclusive: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive
not ok 20 hmm.hmm_device_private.exclusive
#  RUN           hmm.hmm_device_private.exclusive_mprotect ...
# hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
close returned (-1) fd is (3)
# exclusive_mprotect: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive_mprotect
not ok 21 hmm.hmm_device_private.exclusive_mprotect
#  RUN           hmm.hmm_device_private.exclusive_cow ...
# hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
close returned (-1) fd is (3)
# exclusive_cow: Test failed at step #1
#          FAIL  hmm.hmm_device_private.exclusive_cow
not ok 22 hmm.hmm_device_private.exclusive_cow

I'll try to check more closely but maybe if you can reproduce it too, you'll
have more idea what's going on.

The next thing is more of a question/documentation suggestion. Tons of tests
fail like this:

ok 24 hmm.hmm_device_private.hmm_cow_in_device
#  RUN           hmm.hmm_device_coherent.open_close ...
could not open hmm dmirror driver (/dev/hmm_dmirror2)
#      SKIP      DEVICE_COHERENT not available
#            OK  hmm.hmm_device_coherent.open_close

I assume this is because I run "test_hmm.sh smoke" without the SPM parameters.
The help message doesn't say much about what to specify there for
<spm_addr_dev0> <spm_addr_dev1>. Do these tests need a particular hardware?
(unlike the rest?) Maybe it could be clarified.

Last thing, I noticed all these DEVICE_COHERENT tests ultimately count as OK,
not SKIPPED, which would probably be more appropriate?

# FAILED: 51 / 54 tests passed.
# Totals: pass:50 fail:3 xfail:0 xpass:0 skip:1 error:0

(the skip:1 is due to test 9 "#      SKIP      Huge page could not be allocated"
which is probably a misconfiguration on my part so I don't report that as an issue)

Thanks,
Vlastimil
