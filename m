Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BA1A4B57
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJUpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 16:45:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:37826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgDJUpJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 16:45:09 -0400
IronPort-SDR: 3whyYo5dZuhI1StrbKFEn1HUarpQ0K5SxClT5/nlCXxlcwEsW9G8fBBE+BQMscIWPYAjmY0sfP
 gItFvQNQpJaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 13:45:09 -0700
IronPort-SDR: Ida5El/CDEgkpHlIE1XkMu5+hmSvqVIP63Z+oh/fQEnmStIi9kcXxf8FgolAcp0RC8MhUdrVCZ
 aECBWHySm81Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="276291867"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 13:45:09 -0700
Date:   Fri, 10 Apr 2020 13:45:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, drjones@redhat.com,
        david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krish.sadhukhan@oracle.com
Subject: Re: [PATCH v5 0/2] selftests: kvm: Introduce the mem_slot_test test
Message-ID: <20200410204509.GK22482@linux.intel.com>
References: <20200409220905.26573-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409220905.26573-1-wainersm@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 09, 2020 at 07:09:03PM -0300, Wainer dos Santos Moschetta wrote:
> This series introduces a new KVM selftest (mem_slot_test) that goal
> is to verify memory slots can be added up to the maximum allowed. An
> extra slot is attempted which should occur on error.
> 
> The patch 01 is needed so that the VM fd can be accessed from the
> test code (for the ioctl call attempting to add an extra slot).
> 
> I ran the test successfully on x86_64, aarch64, and s390x.  This
> is why it is enabled to build on those arches.

Any objection to folding these patches into a series I have to clean up
set_memory_region_test (which was mentioned in a prior version) and add
this as a testcase to set_memory_region_test instead of creating a whole
new test?

A large chunk of set_memory_region_test will still be x86_64 only, but
having the test reside in common code will hopefully make it easier to
extend to other architectures.
