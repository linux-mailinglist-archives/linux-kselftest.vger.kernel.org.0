Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD218072
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEHTa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 15:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfEHTa0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 15:30:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79EFBC05E757;
        Wed,  8 May 2019 19:30:26 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D5060C9A;
        Wed,  8 May 2019 19:30:23 +0000 (UTC)
Date:   Wed, 8 May 2019 15:30:22 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>
Subject: Build-time tests?
Message-ID: <20190508191341.GA17963@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 08 May 2019 19:30:26 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello kbuild, kselftest,

I've been working on a patchset which adds an additional build script to
the toolchain when compiling livepatches.  There are a few kernel
section features in which this script does not yet support, but can
detect and abort when it encounters.  To test this detection, I've
written a small set of kernel modules that require such sections.

A few questions: 

Is build-testing out of scope for kernel selftests?  For expediency,
it was really easy to spin out new lib/livepatch kernel modules.

Does kbuild support the notion of expected failure?  In this case, the
build script returns a non-zero error and the build stops.

Am I trying to fit a square peg in a round hole?  I could easily keep
these build tests in a private branch, but could they exist in a
different format somewhere else in the tree?

Suggestions welcome,

-- Joe
