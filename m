Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0F598C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiHRSyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiHRSyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 14:54:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72F501AC;
        Thu, 18 Aug 2022 11:53:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso3038414wma.2;
        Thu, 18 Aug 2022 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8WO9HL2c2NqU95pngV5GpcHf00yCayPpvaZNx/fy4Qg=;
        b=UbCFQNesxAG/TMAva+KxIhwUYfVzWv9gUtIty6rIcwZhJUeg94eD6pHJnPEjSnAaTP
         VLNBSxOAWoszSycCRx0G2oBgnX1GiwZdNppAZRXP3GKuMr11AV6YdUWcyeIXg7JUQe1k
         EdQlKsNgEB36LuBWJ8qfnjY+AEmPJKRWHxGwhTDlBn8U3+EzKP4ltNDfcNSHUAys0j1p
         YkeAlyJ/ZIt6Ikt+ItKqOGPLZspZziU+6TE/NfiQuv0/QBiE490/6BELVp0ln34amb0e
         fw6+XvKwnlej9kDMqFPFF/fnhbxR6pFWns+eUAQh+htwsab7tpELxZ/k1LRudQU3tUj+
         FJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8WO9HL2c2NqU95pngV5GpcHf00yCayPpvaZNx/fy4Qg=;
        b=aR/l/KgZk/oclocXZK0Az0wMf4exBDxnqKvoTUomK6zZWhp1HvpawPOLIIcPdXNUrx
         KmeHgS69peD2hfCEsEmsA41VaMPFz/vrsxNYpGWtT5bswpwMcfe9JoEjfGPdQfRF/Yo8
         cKtOfptQVV6KTgST6+4V+M+SnJ1thAyWCECCqy64Ldfce0K0O18OOABNSOvE5gBnK+/m
         wux8t+O6xd3yzuUBejr+U3qb8EUCzRuCHuU6eUhWyzyguOw2MUzrFPtDK6LLoDsbLEzH
         EQk9k71Ritc4HLT/aNkvjMqw84+YNBgyJb8wAqI0vCr3RASNxWgyOpAISZTWIqSiqWhY
         hPvg==
X-Gm-Message-State: ACgBeo0f1aWlZv9qxkF8RAUzduWhFL2y5iDYcQPEH3QXsY0RzP+lhHgk
        EI9cV4C+I9N3ukL6m/hMIwG1nULNhTKFJdOz9gc=
X-Google-Smtp-Source: AA6agR46oRNeeGo27+7ipy9Q22youWVJtPxD+mUVYW0JIxbV7pnrzYdTTnH7mQzLg7sPvqq1Wkntl3khnXg+3ZbKUkY=
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id
 10-20020a05600c020a00b003a5a700017dmr2678817wmi.148.1660848837489; Thu, 18
 Aug 2022 11:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGi-RUKv-8zyku-3pjXdjxbyMP_X_YV5rd6y2wyaCOJJ9UOQAw@mail.gmail.com>
 <CABVgOSnxa=H5A-0U0QRCAv+OWCGb0zN_f7gP5FmhGjRy7NCUSw@mail.gmail.com>
 <CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com> <443632b6-c589-ef62-2385-3e8406680343@gmail.com>
In-Reply-To: <443632b6-c589-ef62-2385-3e8406680343@gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Thu, 18 Aug 2022 21:53:45 +0300
Message-ID: <CAGi-RULAXRc0NZYMEokvS-P=zuNos==fm-8PvCiu83vVmw47HQ@mail.gmail.com>
Subject: Re: Running kunit tests on platform devices
To:     CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 18, 2022 at 9:08 PM Tales Lelo da Aparecida
<tales.aparecida@gmail.com> wrote:
>
> On 17/08/2022 09:19, Ramon Fried wrote:
> > On Wed, Aug 17, 2022 at 7:43 AM David Gow <davidgow@google.com> wrote:
> >>
> >> On Mon, Aug 15, 2022 at 5:16 PM Ramon Fried <rfried.dev@gmail.com> wrote:
> >>>
> >>> Hi.
> >>> I implemented a test suite that checks a platform driver, that's the
> >>> only way I can test interrupts behavior in the code.
> >>> Because it's a platform, I can't use kunit_test_suite(), so I call
> >>> __kunit_test_suites_init() as part of the platform driver probe
> >>> function.
> >>>
> >>> This works fine but has the following problems.
> >>> "TAP version 14" string is not printed and it's impossible to parse
> >>> the results using the script.
> >>> In addition, the suite is not displayed in /sys/kernel/debug/kunit.
> >>>
> >>> It would be my pleasure to provide a patch that fixes this, I just
> >>> wanted to make sure that my testing strategy makes sense.
> >>>
> >>> Thanks,
> >>> Ramon
> >>>
> >> Hi Ramon,
> >>
> >> Thanks for reaching out. Calling __kunit_test_suites_init() directly
> >> is not something we'd recommend (and are trying desperately to remove
> >> existing uses), so several of the issues re: the "TAP version 14"
> >> string et al are side effects of calling what is supposed to be an
> >> internal KUnit function manually.
> >>
> >> That being said, we definitely do want to make testing platform
> >> drivers as convenient as possible. I'm not sure why kunit_test_suite()
> >> doesn't work for you for platform drivers: are you just missing some
> >> way of instantiating the device from within a test context?
> >>
> >> I know Brendan has experimented with some hardware faking code, for
> >> which there's some example use here:
> >> https://kunit-review.googlesource.com/c/linux/+/5275
> >> (Note that you'll need to look at the other patches in the 'relation
> >> chain' for dependencies.)
> >>
> >> Equally, I've experimented a bit with testing old soundcard drivers
> >> (via a platform device) here, which may be an easier way to look
> >> through:
> >> https://github.com/sulix/linux/commit/4e1620c86553b9edde7f032318cf417dc13e4d26
> >>
> >> Note that neither of those examples are anything other than
> >> experiments, so may not work as-is, or be ideal.
> >>
> >> Otherwise, we're always happy to accept patches, though again, if
> >> there's any way of getting your tests working without a direct call to
> >> __kunit_test_suites_init() --- even if that would require patches to
> >> work --- that'd be preferable on our end.
> >>
> >> Cheers,
> >> -- David
> > Hi David,
> > Thanks for replying.
> > I looked at the examples you shared, and they all fake the actual device.
> > My intention is to actually interact with the real device. - get a
> > real interrupt, etc.
> > Is it wrong, was the intention that the platform device be mocked ?
> > Thanks,
> > Ramon.
> >
>
> Hi, Ramon,
>
> I particularly don't condemn writing tests that require hardware, but
> they're best avoided, mostly to facilitate running those tests.
>
> Can you share your code?
Sure.
> I would be happy to take a look if its not a problem for you!
>
> Kind regards,
> Tales


// SPDX-License-Identifier: GPL-2.0
#include <linux/nr_hwsw_queues.h>
#include <linux/module.h>
#include <kunit/test.h>
#include <linux/device.h>
#include <linux/dma-mapping.h>
#include <linux/platform_device.h>
#include <linux/of_address.h>
#include <linux/irq.h>
#include <linux/interrupt.h>

#define ASPEN_HW_SW_QUEUES_OFFSET 0x02300000
#define ASPEN_HW_SW_QUEUES_SIZE 0x80000

#define HW_SW_QUEUES_TEST_SINGLE_QUEUE_CFG_REG_MEMORY_MAP_SIZE (0x1000)
#define HW_SW_QUEUES_TEST_QUEUES_CFG_REG_MEMORY_MAP_SIZE (0x2000)

#define HW_SW_QUEUES_TEST_HW2SW_QUEUE_CFG_OFFSET (0)
#define HW_SW_QUEUES_TEST_HW2SW_QUEUE_COMMON_CFG_OFFSET (0x40)

#define HW_SW_QUEUES_TEST_SW2HW_QUEUE_CFG_OFFSET (0x1000)
#define HW_SW_QUEUES_TEST_SW2HW_QUEUE_COMMON_CFG_OFFSET (0x1020)

#define QUEUE_DEPTH_MIN_SIZE (256)
#define QUEUE_DEPTH_MAX_SIZE (1024)
#define QUEUE_ELEM_MIN_SIZE (8)
#define QUEUE_ELEM_MAX_SIZE (64)
#define HW_SW_QUEUES_TEST_SINGLE_QUEUE_DATA_REG_MEMORY_MAP_SIZE \
(QUEUE_DEPTH_MAX_SIZE * QUEUE_ELEM_MAX_SIZE)
#define HW_SW_QUEUES_TEST_QUEUES_DATA_REG_MEMORY_MAP_SIZE \
(HW_SW_QUEUES_TEST_SINGLE_QUEUE_DATA_REG_MEMORY_MAP_SIZE * 2)

#define HW_SW_QUEUES_TEST_HW2SW_QUEUE_DATA_OFFSET (0x2000)
#define HW_SW_QUEUES_TEST_SW2HW_QUEUE_DATA_OFFSET
(HW_SW_QUEUES_TEST_HW2SW_QUEUE_DATA_OFFSET + \
HW_SW_QUEUES_TEST_SINGLE_QUEUE_DATA_REG_MEMORY_MAP_SIZE)

struct queue_element {
u64 value1;
};

struct test_context {
struct nr_sw_hw_queue sw_hw_queue;
struct nr_hw_sw_queue hw_sw_queue;
volatile bool irq_occurred;
};

struct suite_context {
struct platform_device *pdev;
};

static struct suite_context g_context;

irqreturn_t hw_sw_queue_irq_handler(int irq, void *ctx)
{
struct kunit *test = ctx;
struct test_context *context = test->priv;

kunit_info(test, "IRQ handler\n");

nr_hw_sw_consume(&context->hw_sw_queue, 1);
nr_hw_sw_queue_clear_irq(&context->hw_sw_queue, 0);

context->irq_occurred = true;

return IRQ_HANDLED;
}

static void hw_sw_queues_simple_irq_test(struct kunit *test)
{
struct test_context *context = test->priv;
int ret;
void *addr;

kunit_info(test, "Executing test\n");

context->irq_occurred = false;

KUNIT_EXPECT_EQ(test, nr_hw_sw_queue_init(&context->hw_sw_queue), 0);
KUNIT_EXPECT_EQ(test, nr_sw_hw_queue_init(&context->sw_hw_queue), 0);

nr_hw_sw_queue_unmask_irq(&context->hw_sw_queue);
nr_hw_sw_queue_enable(&context->hw_sw_queue);
nr_sw_hw_queue_enable(&context->sw_hw_queue);

ret = request_threaded_irq(context->hw_sw_queue.irq, hw_sw_queue_irq_handler,
   NULL, IRQF_SHARED  | IRQF_TRIGGER_HIGH, "hw_sw_irq", test);

KUNIT_EXPECT_EQ(test, ret, 0);

nr_sw_hw_get_next_free_entry(&context->sw_hw_queue, &addr);
nr_sw_hw_produce(&context->sw_hw_queue, 1);

KUNIT_EXPECT_EQ(test, ret, 0);

while (!context->irq_occurred)
;
}

static int hw_sw_queues_test_init(struct kunit *test)
{
struct test_context *context;

context = kzalloc(sizeof(*context), GFP_KERNEL);
test->priv = context;

kunit_info(test, "initializing\n");

context->hw_sw_queue.common.element_size = sizeof(struct queue_element);
context->hw_sw_queue.common.queue_depth = 8;
context->hw_sw_queue.common.config_base = ioremap(ASPEN_HW_SW_QUEUES_OFFSET,
  ASPEN_HW_SW_QUEUES_SIZE);
context->hw_sw_queue.irq_threshold = 1;
context->hw_sw_queue.irq = platform_get_irq(g_context.pdev, 0);
if (context->hw_sw_queue.irq < 0)
return -1;

context->sw_hw_queue.common.element_size = sizeof(struct queue_element);
context->sw_hw_queue.common.queue_depth = 8;
context->sw_hw_queue.common.config_base =
context->hw_sw_queue.common.config_base +
HW_SW_QUEUES_TEST_SW2HW_QUEUE_CFG_OFFSET;

context->hw_sw_queue.common.virtual_base =
context->hw_sw_queue.common.config_base +
HW_SW_QUEUES_TEST_HW2SW_QUEUE_DATA_OFFSET;
context->hw_sw_queue.common.physical_base = ASPEN_HW_SW_QUEUES_OFFSET +
HW_SW_QUEUES_TEST_HW2SW_QUEUE_DATA_OFFSET;

context->sw_hw_queue.common.virtual_base =
context->hw_sw_queue.common.config_base +
HW_SW_QUEUES_TEST_SW2HW_QUEUE_DATA_OFFSET;
context->sw_hw_queue.common.physical_base = ASPEN_HW_SW_QUEUES_OFFSET +
HW_SW_QUEUES_TEST_SW2HW_QUEUE_DATA_OFFSET;

return 0;
}

static void hw_sw_queues_test_exit(struct kunit *test)
{
struct test_context *context = test->priv;

kunit_info(test, "deinitializing\n");
iounmap(context->hw_sw_queue.common.config_base);
free_irq(context->hw_sw_queue.irq, test);

kfree(context);
}

static struct kunit_case hw_sw_queues_test_cases[] = {
KUNIT_CASE(hw_sw_queues_simple_irq_test),
{}
};

static struct kunit_suite nr_hwsw_queues_test_suite = {
.name = "nr_hwsw_queues",
.init = hw_sw_queues_test_init,
.exit = hw_sw_queues_test_exit,
.test_cases = hw_sw_queues_test_cases,
};

static struct kunit_suite *nr_hwsw_queues_test_suites[] = {
&nr_hwsw_queues_test_suite,
NULL
};

static int nr_hw_sw_queues_test_probe(struct platform_device *pdev)
{
g_context.pdev = pdev;
pr_info("TAP version 14\n");
pr_info("1..1\n");
return __kunit_test_suites_init(nr_hwsw_queues_test_suites);
}

static int nr_hw_sw_queues_test_remove(struct platform_device *pdev)
{
__kunit_test_suites_exit(nr_hwsw_queues_test_suites);
return 0;
}

static const struct of_device_id nr_hw_sw_queues_test_of_match[] = {
{.compatible = "nr,hw_sw_queus_test",},
{},
};

MODULE_DEVICE_TABLE(of, nr_hw_sw_queues_test_of_match);

static struct platform_driver nr_hw_sw_queues_test = {
.driver = {
.name  = "nr_hw_sw_queues_test",
.of_match_table = nr_hw_sw_queues_test_of_match,
},
.probe = nr_hw_sw_queues_test_probe,
.remove = nr_hw_sw_queues_test_remove,
};

module_platform_driver(nr_hw_sw_queues_test);
MODULE_LICENSE("GPL");
